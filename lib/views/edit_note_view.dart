import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/add_note_cubit/notes_cubit/notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/theme_cubit/cubit/theme_cubit.dart';
import 'package:notes_app/widgets/custom_text_field.dart';
import 'package:notes_app/widgets/edit_notes_colors_list_view.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  String? title, content;
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state == ThemeMode.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.grey[200];
    // final cardColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
    // final textColor = isDarkMode ? Colors.white : Colors.black87;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Edit Note",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
              IconButton(
                onPressed: () {
                  widget.note.title = title ?? widget.note.title;
                  widget.note.subTitle = content ?? widget.note.subTitle;
                  widget.note.save();
                  BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: const Row(
                        children: [
                          Icon(Icons.check, size: 27, color: Colors.white),
                          SizedBox(width: 20),
                          Text(
                            "Note updatd successfuly",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green.shade500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.check, size: 28),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              const SizedBox(),
              CustomTextField(
                onChanged: (value) {
                  title = value;
                },
                hint: "Title",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                onChanged: (value) {
                  content = value;
                },
                hint: "Content",
                maxLines: 5,
              ),
              const SizedBox(height: 80),
              EditNoteColorsListView(note: widget.note),
            ],
          ),
        ),
      ),
    );
  }
}
