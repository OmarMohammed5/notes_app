import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.maxLines = 1,
    this.onSaved,
    this.onChanged,
    this.style,
    this.hintStyle,
  });

  final void Function(String?)? onSaved;
  final String hint;
  final int maxLines;
  final void Function(String)? onChanged;
  final TextStyle? style;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor = isDark ? Colors.white : const Color(0xFF202124);
    final defaultHintColor = isDark
        ? const Color(0xFF888888)
        : const Color(0xFF9E9E9E);

    return TextFormField(
      onChanged: onChanged,
      onSaved: onSaved,
      maxLines: maxLines,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Field is required";
        }
        return null;
      },
      style:
          style ??
          TextStyle(fontSize: 16, height: 1.75, color: defaultTextColor),
      cursorColor: isDark ? Colors.white54 : Colors.black54,
      cursorWidth: 1.5,
      decoration: InputDecoration(
        // ── Fully invisible — no borders, no background ──
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        filled: false,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        hintText: hint,
        hintStyle:
            hintStyle ??
            TextStyle(fontSize: 16, height: 1.75, color: defaultHintColor),
        // Show error message without a border
        errorStyle: const TextStyle(
          fontSize: 11,
          color: Colors.redAccent,
          height: 1.2,
        ),
      ),
    );
  }
}
