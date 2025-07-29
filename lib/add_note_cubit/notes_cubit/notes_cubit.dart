// part of 'add_note_state.dart';

import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/add_note_cubit/notes_cubit/notes_state.dart';
import 'package:notes_app/constant.dart';
import 'package:notes_app/models/note_model.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  fetchAllNotes(NoteModel note) async {
    try {
      var notesBox = Hive.box<NoteModel>(kNotesBox);
      emit(NotesSuccess(notesBox.values.toList()));
    } catch (e) {
      emit(NotesFailure(e.toString()));
    }
  }
}
