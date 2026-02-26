import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyActions: false,
        title: Text(
          'Settings',
          style: GoogleFonts.fingerPaint(
            fontSize: 22,
            fontWeight: FontWeight.bold, // Bold
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        // iconTheme:const IconThemeData(),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp, size: 22),
        ),
        centerTitle: true,
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
        ],
      ),
    );
  }
}
