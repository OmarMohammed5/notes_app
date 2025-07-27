import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/views/edit_note_view.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.color});

  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return EditNoteView();
            },
          ),
        );
      },
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(18),
          color: color,
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Text(
                    "Flutter Tips",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 152),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Icon(
                      FontAwesomeIcons.trash,
                      size: 22,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30),
                Text(
                  "Build your career with",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30),
                Text(
                  "Omar Mohammed",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Text(
                    "July 27,2025",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.4),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
