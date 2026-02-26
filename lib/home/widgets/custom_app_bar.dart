import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/settings/view/settings_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      elevation: 0,
      backgroundColor: isDark
          ? Colors.grey.shade900.withValues(alpha: 0.7)
          : Colors.grey.shade300.withValues(alpha: 0.4),
      toolbarHeight: 65,
      centerTitle: false,
      title: Text(
        'Noota',
        style: GoogleFonts.fingerPaint(
          fontSize: 24,
          fontWeight: FontWeight.bold, // Bold
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsView()),
            );
          },
          icon: const Icon(Icons.settings_outlined, size: 27),
        ),
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
