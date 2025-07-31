import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/add_note_cubit/notes_cubit/notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/custom_text_field.dart';
import 'package:notes_app/widgets/edit_notes_colors_list_view.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  String? title, content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Edit Note",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xff323233),
              ),
              child: IconButton(
                onPressed: () {
                  widget.note.title = title ?? widget.note.title;
                  widget.note.subTitle = content ?? widget.note.subTitle;
                  widget.note.save();
                  BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const SizedBox(),
            CustomTextField(
              onChanged: (value) {
                title = value;
              },
              hint: "Title",
            ),
            const SizedBox(height: 20),
            CustomTextField(
              onChanged: (value) {
                content = value;
              },
              hint: "Content",
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            EditNoteColorsListView(note: widget.note),
          ],
        ),
      ),
    );
  }
}
