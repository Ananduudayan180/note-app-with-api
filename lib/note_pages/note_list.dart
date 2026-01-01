import 'package:flutter/material.dart';
import 'package:note_app/data/data.dart';
import 'package:note_app/data/note_model/note_model.dart';
import 'package:note_app/note_pages/add_note.dart';
import 'package:note_app/utils/app_colors.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => NoteListState();
}

class NoteListState extends State<NoteList> {
  final List<NoteModel> notesList = [];
  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    await NoteDB().getAllNote();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ValueListenableBuilder(
      valueListenable: NoteDB().noteListNotifier,
      builder: (BuildContext context, noteList, Widget? child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final note = noteList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              //Edit note tap
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AddEditNote(noteModel: note);
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.appContainerColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    title: Text(
                      note.title ?? 'No Title',
                      style: textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      note.content ?? 'No Content',
                      style: textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        // Handle delete action
                        NoteDB().deleteNote(note.id.toString());
                      },
                      icon: Icon(Icons.delete),
                      color: AppColors.appThemeColor,
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: noteList.length,
        );
      },
    );
  }
}
