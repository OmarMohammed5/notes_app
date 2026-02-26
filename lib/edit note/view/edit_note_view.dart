import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/add_note_cubit/notes_cubit/notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({super.key, required this.note});
  final NoteModel note;

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late TextEditingController titleController;
  late TextEditingController subTitleController;

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _bodyFocus = FocusNode();

  bool _hasChanges = false;

  final List<String> _undoStack = [];
  final List<String> _redoStack = [];
  String _lastText = '';

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    subTitleController = TextEditingController(text: widget.note.subTitle);
    _lastText = widget.note.subTitle;

    titleController.addListener(_checkChanges);
    subTitleController.addListener(() {
      _checkChanges();
      _trackUndo();
    });
  }

  void _checkChanges() {
    final changed =
        titleController.text != widget.note.title ||
        subTitleController.text != widget.note.subTitle;
    if (changed != _hasChanges) setState(() => _hasChanges = changed);
  }

  void _trackUndo() {
    final current = subTitleController.text;
    if (current != _lastText) {
      _undoStack.add(_lastText);
      _redoStack.clear();
      _lastText = current;
    }
  }

  void _undo() {
    if (_undoStack.isEmpty) return;
    final prev = _undoStack.removeLast();
    _redoStack.add(subTitleController.text);
    _lastText = prev;
    subTitleController.value = TextEditingValue(
      text: prev,
      selection: TextSelection.collapsed(offset: prev.length),
    );
    HapticFeedback.selectionClick();
    setState(() {});
  }

  void _redo() {
    if (_redoStack.isEmpty) return;
    final next = _redoStack.removeLast();
    _undoStack.add(subTitleController.text);
    _lastText = next;
    subTitleController.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: next.length),
    );
    HapticFeedback.selectionClick();
    setState(() {});
  }

  void saveNote() {
    final newTitle = titleController.text.trim();
    final newSubTitle = subTitleController.text;
    if (newTitle == widget.note.title && newSubTitle == widget.note.subTitle) {
      return;
    }
    widget.note.title = newTitle.isEmpty ? 'Untitled' : newTitle;
    widget.note.subTitle = newSubTitle;
    widget.note.save();
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Note updated successfully"),
        backgroundColor: const Color(0xFF3C3C3C),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    _titleFocus.dispose();
    _bodyFocus.dispose();
    super.dispose();
  }

  // ── Invisible TextField decoration ─────────────────────────
  // Zero borders, zero padding, transparent — looks like plain Text
  InputDecoration _invisibleDecoration({String? hint, TextStyle? hintStyle}) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      filled: false,
      isDense: true,
      contentPadding: EdgeInsets.zero,
      hintText: hint,
      hintStyle: hintStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? Colors.black : Colors.white;
    final titleColor = isDark ? Colors.white : Colors.black;
    final bodyColor = isDark
        ? const Color(0xFFE0E0E0)
        : const Color(0xFF212121);
    final mutedColor = isDark
        ? const Color(0xFF888888)
        : const Color(0xFF9E9E9E);
    final appBarIconColor = isDark
        ? const Color(0xFFCCCCCC)
        : const Color(0xFF424242);

    final formattedDate = DateFormat(
      'MMM d, yyyy, hh:mm a',
    ).format(DateTime.parse(widget.note.date));
    // final charCount = subTitleController.text.length;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (_hasChanges) saveNote();
        BlocProvider.of<NotesCubit>(context).fetchAllNotes();
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: bgColor,
          resizeToAvoidBottomInset: true,

          // ── AppBar ───────────────────────────────────────────
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              onPressed: () {
                if (_hasChanges) saveNote();
                BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.chevron_left_rounded,
                color: appBarIconColor,
                size: 28,
              ),
            ),
            actions: [
              IconButton(
                onPressed: _undoStack.isNotEmpty ? _undo : null,
                tooltip: "Undo",
                icon: Icon(
                  Icons.undo_rounded,
                  color: _undoStack.isNotEmpty
                      ? appBarIconColor
                      : appBarIconColor.withValues(alpha: .3),
                  size: 24,
                ),
              ),
              IconButton(
                onPressed: _redoStack.isNotEmpty ? _redo : null,
                tooltip: "Redo",
                icon: Icon(
                  Icons.redo_rounded,
                  color: _redoStack.isNotEmpty
                      ? appBarIconColor
                      : appBarIconColor.withValues(alpha: .3),
                  size: 24,
                ),
              ),

              IconButton(
                onPressed: () {
                  saveNote();
                  BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                  Navigator.pop(context);
                },
                tooltip: "Save",
                icon: Icon(Icons.check, color: appBarIconColor, size: 24),
              ),
              const SizedBox(width: 4),
            ],
          ),

          // ── Body ─────────────────────────────────────────────
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── TITLE — always a TextField, invisible styling ──
                      TextField(
                        controller: titleController,
                        focusNode: _titleFocus,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => _bodyFocus.requestFocus(),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                          height: 1.3,
                        ),
                        decoration: _invisibleDecoration(
                          hint: "Title",
                          hintStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: mutedColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // ── DATE + CHAR COUNT ──────────────────────────────
                      Text(
                        formattedDate,
                        style: TextStyle(fontSize: 13, color: mutedColor),
                      ),

                      const SizedBox(height: 10),
                      Divider(
                        color: isDark ? Colors.grey.shade700 : Colors.black26,
                      ),
                      const SizedBox(height: 30),

                      // ── BODY — always a TextField, invisible styling ───
                      TextField(
                        controller: subTitleController,
                        focusNode: _bodyFocus,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: 17,
                          height: 1.75,
                          color: bodyColor,
                        ),
                        decoration: _invisibleDecoration(
                          hint: "Start writing...",
                          hintStyle: TextStyle(
                            fontSize: 17,
                            height: 1.75,
                            color: mutedColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
