import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/add_note_cubit/notes_cubit/notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/views/edit_note_view.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.color, required this.note});

  final Color color;
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String formattedDate = DateFormat(
      'dd MMM yyyy',
    ).format(DateTime.parse(note.date));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditNoteView(note: note)),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Color(note.color),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Delete Icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: TextStyle(
                      fontSize: 26,
                      color: isDark ? Colors.black87 : Colors.white,
                      // color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    note.delete();
                    BlocProvider.of<NotesCubit>(context).fetchAllNotes();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: const Row(
                          children: [
                            Icon(Icons.check, color: Colors.white),
                            SizedBox(width: 20),
                            Text(
                              "Note deleted successfuly",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    FontAwesomeIcons.trash,
                    color: isDark ? Colors.black : Colors.white,
                    size: 22,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Subtitle (expands with text)
            Text(
              note.subTitle,
              style: TextStyle(
                fontSize: 18,
                height: 1.4,
                color: isDark
                    ? Colors.black.withValues(alpha: 0.6)
                    : Colors.white70,
              ),
            ),

            const SizedBox(height: 12),

            // Date
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.5)
                      : Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
