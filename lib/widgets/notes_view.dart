import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:notes_app/theme_cubit/cubit/theme_cubit.dart';
import 'package:notes_app/views/settings_view.dart';
import 'package:notes_app/widgets/add_note_bottom_sheet.dart';
import 'package:notes_app/widgets/notes_list_view.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state == ThemeMode.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.grey[200];
    // final cardColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
    // final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ============ Logo + Title ============
            Row(
              children: [
                const Center(child: Icon(Icons.note_alt_outlined, size: 30)),
                const SizedBox(width: 12),
                Text(
                  "Noota",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),

            // ============ Icons Section ============
            Row(
              children: [
                // Settings Icon
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsView(),
                      ),
                    );
                  },
                  child: const Center(
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedSettings01,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [Expanded(child: NotesListView())]),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddNoteBottomSheet();
              },
            );
          },
          shape: const CircleBorder(),
          backgroundColor: const Color(0xff60ffd7),
          child: const Icon(FontAwesomeIcons.plus, color: Colors.black),
        ),
      ),
    );
  }
}
