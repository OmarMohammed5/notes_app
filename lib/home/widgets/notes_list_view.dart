import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/add_note_cubit/notes_cubit/notes_cubit.dart';
import 'package:notes_app/add_note_cubit/notes_cubit/notes_state.dart';
import 'package:notes_app/edit%20note/view/edit_note_view.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/home/widgets/custom_card.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<NotesCubit>(context);
        if (cubit.notes == null) {
          cubit.fetchAllNotes();
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        List<NoteModel> notes = cubit.notes!;
        if (notes.isEmpty) {
          return Center(
            child: Lottie.asset("assets/empty.json", height: 300, width: 300),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ListView.builder(
            itemCount: notes.length,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: CustomCard(
                  note: notes[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditNoteView(note: notes[index]);
                        },
                      ),
                    );
                  },
                  onDelete: () {
                    notes[index].delete();
                    BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
