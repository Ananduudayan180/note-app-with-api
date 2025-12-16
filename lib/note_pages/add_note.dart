import 'package:flutter/material.dart';
import 'package:note_app/utils/app_colors.dart';
import 'package:note_app/utils/app_str.dart';

class AddEditNote extends StatefulWidget {
  const AddEditNote({
    super.key,
    required this.title,
    required this.description,
  });

  final String? title;
  final String? description;

  @override
  State<AddEditNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddEditNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void initState() {
    if (widget.title != null || widget.description != null) {
      _titleController.text = widget.title ?? '';
      _descriptionController.text = widget.description ?? '';
    }
    super.initState();
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
            onPressed: () {
              //Save note action
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
}
