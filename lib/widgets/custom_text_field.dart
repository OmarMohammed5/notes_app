import 'package:flutter/material.dart';
import 'package:notes_app/constant.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hint, this.maxLines = 1});

  final String hint;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        maxLines: maxLines,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: kPrimaryColor),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
