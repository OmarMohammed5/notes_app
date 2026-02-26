// part of 'add_note_state.dart';

import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:notes_app/add_note_cubit/add_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/add_note_cubit/notes_cubit/notes_cubit.dart';
import 'package:notes_app/constant.dart';
import 'package:notes_app/models/note_model.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  final NotesCubit notesCubit;

  AddNoteCubit(this.notesCubit) : super(AddNoteInitial());

  Color color = const Color(0xffDB3A34);
  addNote(NoteModel note) async {
    // ignore: deprecated_member_use
    note.color = color.value;
    emit(AddNoteLoading());
    try {
      var notesBox = Hive.box<NoteModel>(kNotesBox);
      await notesBox.add(note);
      notesCubit.fetchAllNotes();
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteFailure(e.toString()));
    }
  }
}
