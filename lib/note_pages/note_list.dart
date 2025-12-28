import 'package:flutter/material.dart';
import 'package:note_app/data/data.dart';
import 'package:note_app/data/note_model/note_model.dart';
import 'package:note_app/utils/app_colors.dart';

class NoteList extends StatefulWidget {
  final Function? refreshNotes;
  const NoteList({super.key, this.refreshNotes});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final List<NoteModel> notesList = [];
  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    final notes = await NoteDB().getAllNote();
    setState(() {
      notesList.clear();
      notesList.addAll(notes.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ListView.builder(
      itemBuilder: (context, index) {
        final NoteModel note = notesList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              // Handle note tap
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
                  },
                  icon: Icon(Icons.delete),
                  color: AppColors.appThemeColor,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: notesList.length,
    );
  }
}
