import 'package:flutter/material.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Edit Note",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
                color: Color(0xff323233),
              ),
              child: Icon(Icons.check, size: 25, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            SizedBox(),
            CustomTextField(hint: "Title"),
            SizedBox(height: 20),
            CustomTextField(hint: "Content", maxLines: 5),
          ],
        ),
      ),
    );
  }
}
