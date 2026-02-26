import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/theme_cubit/cubit/theme_cubit.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state == ThemeMode.dark;

    // Colors depending on theme
    final backgroundColor = isDarkMode ? Colors.black : Colors.grey[200];
    final cardColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subTextColor = isDarkMode ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        backgroundColor: isDarkMode ? Colors.black : Colors.grey[200],
        foregroundColor: isDarkMode ? Colors.white : Colors.black87,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ================ Dark && Light Mode ==================
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (!isDarkMode)
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.dark_mode, color: textColor, size: 28),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Dark Mode",
                    style: TextStyle(color: textColor, fontSize: 18),
                  ),
                ),
                Switch(
                  activeThumbColor: Colors.tealAccent,
                  value: isDarkMode,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ================ About ==================
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (!isDarkMode)
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About App",
                  style: TextStyle(fontSize: 18, color: textColor),
                ),
                const SizedBox(height: 10),
                Text(
                  "Notes App v1.0.0",
                  style: TextStyle(color: subTextColor, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  "Developed by Omar Mohammed",
                  style: TextStyle(color: subTextColor, fontSize: 16),
                ),
                const SizedBox(height: 15),
                Text(
                  "Summary :",
                  style: TextStyle(fontSize: 17, color: textColor),
                ),
                const SizedBox(height: 5),
                Text(
                  "Notes App allows users to add, edit, and delete notes. "
                  "Users can also choose a color for each note to organize and personalize their notes easily.",
                  style: TextStyle(color: subTextColor, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
