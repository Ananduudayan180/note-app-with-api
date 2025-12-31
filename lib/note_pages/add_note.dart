import 'package:flutter/material.dart';
import 'package:note_app/data/data.dart';
import 'package:note_app/data/note_model/note_model.dart';
import 'package:note_app/utils/app_colors.dart';
import 'package:note_app/utils/app_str.dart';

class AddEditNote extends StatefulWidget {
  const AddEditNote({super.key, required this.noteModel});

  final NoteModel? noteModel;

  @override
  State<AddEditNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddEditNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.noteModel != null) {
      _titleController.text = widget.noteModel?.title ?? '';
      _descriptionController.text = widget.noteModel?.content ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      //Appbar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text(
          AppStr.addNote,
          style: themeData.appBarTheme.titleTextStyle,
        ),
        backgroundColor: AppColors.appThemeColor,
        actions: [
          IconButton(
            onPressed: () async {
              //Save note action

              if (widget.noteModel == null) {
                await saveNote();
              } else {
                await updateNote();
              }
              if (!context.mounted) return;
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save_as_outlined),
            color: Colors.white,
          ),
        ],
      ),
      //Text fields to add note
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          child: Column(
            children: [
              //Title TextField
              Container(
                decoration: BoxDecoration(
                  color: AppColors.appContainerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppStr.noteTitle,
                    ),
                    style: themeData.textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.appContainerColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    //Description TextField
                    child: TextField(
                      controller: _descriptionController,
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: AppStr.noteDescription,
                        border: InputBorder.none,
                      ),
                      style: themeData.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveNote() async {
    final title = _titleController.text;
    final description = _descriptionController.text;

    final note = NoteModel.create(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      content: description,
    );
    await NoteDB().createNote(note);
    // if (result != null) {
    //   if (!mounted) return;
    //   Navigator.of(context).pop();
    // } else {}
  }

  Future<void> updateNote() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    if (widget.noteModel!.id == null) {
      Navigator.of(context).pop();
      return;
    }
    final updateNote = NoteModel.create(
      id: widget.noteModel?.id,
      title: title,
      content: description,
    );
    await NoteDB().updateNote(updateNote);
  }
}
