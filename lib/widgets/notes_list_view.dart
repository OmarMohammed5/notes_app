import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/add_note_cubit/notes_cubit/notes_cubit.dart';
import 'package:notes_app/add_note_cubit/notes_cubit/notes_state.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/custom_card.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        // استدعاء fetchAllNotes لو notes لسه null
        final cubit = BlocProvider.of<NotesCubit>(context);
        if (cubit.notes == null) {
          cubit.fetchAllNotes();
          // نعرض شاشة تحميل مؤقتة لحد ما يتم تعبئة notes
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        List<NoteModel> notes = cubit.notes!;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListView.builder(
            itemCount: notes.length,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CustomCard(
                  note: notes[index],
                  color: Color(notes[index].color),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
