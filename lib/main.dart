import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unnecessary_import
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/add_note_cubit/notes_cubit/notes_cubit.dart';
import 'package:notes_app/constant.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/simple_bloc_observer.dart';
import 'package:notes_app/theme/app_themes.dart';
import 'package:notes_app/theme_cubit/cubit/theme_cubit.dart';
import 'package:notes_app/views/notes_view_body.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotesCubit()),
        BlocProvider(create: (context) => NotesCubit()..fetchAllNotes()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: const NotesApp(),
    ),
  );
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          themeMode: themeMode,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          debugShowCheckedModeBanner: false,
          home: const NotesViewBody(),
        );
      },
    );
  }
}
