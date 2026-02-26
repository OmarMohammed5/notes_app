import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/add_note_cubit/add_note_state.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/home/widgets/colors_list_view.dart';
import 'package:notes_app/home/widgets/custom_text_field.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, subTitle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final mutedColor = isDark
        ? const Color(0xFF888888)
        : const Color(0xFF9E9E9E);
    final dividerColor = isDark
        ? Colors.white.withOpacity(0.07)
        : Colors.black.withOpacity(0.08);
    final addBtnColor = isDark
        ? const Color(0xFF2D2D2D)
        : const Color(0xFFF0F0F0);
    final addBtnTextColor = isDark ? Colors.white : const Color(0xFF202124);

    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag handle ────────────────────────────────────
          Center(
            child: Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: mutedColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // ── TITLE field (invisible) ─────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              onSaved: (value) => title = value,
              hint: "Title",
              // hintStyle: TextStyle(
              //   fontSize: 22,
              //   fontWeight: FontWeight.w700,
              //   color: titleColor,
              //   letterSpacing: -0.3,
              //   height: 1.3,
              // ),
              // hintStyle: TextStyle(
              //   fontSize: 22,
              //   fontWeight: FontWeight.w700,
              //   color: mutedColor,
              //   letterSpacing: -0.3,
              // ),
            ),
          ),

          const SizedBox(height: 16),

          // ── Thin divider ───────────────────────────────────
          Container(height: 1, color: dividerColor),

          const SizedBox(height: 16),

          // ── CONTENT field (invisible) ──────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              onSaved: (value) => subTitle = value,
              hint: "Note",
              maxLines: 5,
            ),
          ),

          const SizedBox(height: 24),

          // ── Another divider ────────────────────────────────
          Container(height: 1, color: dividerColor),

          const SizedBox(height: 16),

          // ── Color picker label + row ───────────────────────
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              "NOTE COLOR",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
                color: mutedColor,
              ),
            ),
          ),

          const ColorsListView(),

          const SizedBox(height: 24),

          // ── Add button ─────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<AddNoteCubit, AddNoteState>(
              builder: (context, state) {
                final isLoading = state is AddNoteLoading;
                return GestureDetector(
                  onTap: isLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: const Row(
                                  children: [
                                    Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      "Note added successfully",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                duration: const Duration(seconds: 2),
                                backgroundColor: const Color(0xFF3C3C3C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  16,
                                ),
                              ),
                            );

                            final noteModel = NoteModel(
                              title: title!,
                              subTitle: subTitle!,
                              date: DateTime.now().toString(),
                              color: Colors.blue.value,
                            );
                            BlocProvider.of<AddNoteCubit>(
                              context,
                            ).addNote(noteModel);
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isLoading
                          ? addBtnColor.withOpacity(0.6)
                          : addBtnColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: addBtnTextColor,
                              ),
                            )
                          : Text(
                              "Add Note",
                              style: TextStyle(
                                color: addBtnTextColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
        ],
      ),
    );
  }
}
