import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "assets/images/ic_launcher_foreground.png",
              color: isDark ? Colors.white : Colors.black,
              fit: BoxFit.cover,
              width: 130,
            ),
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
                    size: 23,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
