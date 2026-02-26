import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/home/widgets/add_floating_button.dart';
import 'package:notes_app/home/widgets/custom_app_bar.dart';
import 'package:notes_app/theme_cubit/cubit/theme_cubit.dart';
import 'package:notes_app/home/widgets/notes_list_view.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final isDarkMode = themeCubit.state == ThemeMode.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.grey[200];
    // final cardColor = isDarkMode ? Colors.grey.shade900 : Colors.white;
    // final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(isDarkMode: isDarkMode),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [Expanded(child: NotesListView())]),
      ),
      floatingActionButton: const AddFloatingButton(),
    );
  }
}
