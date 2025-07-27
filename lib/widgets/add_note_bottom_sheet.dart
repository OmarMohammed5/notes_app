import 'package:flutter/material.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 30),
          CustomTextField(hint: "Title"),
          SizedBox(height: 20),
          CustomTextField(hint: "Content", maxLines: 6),
          SizedBox(height: 90),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
