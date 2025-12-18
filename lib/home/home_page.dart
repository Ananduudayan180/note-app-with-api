import 'package:flutter/material.dart';
import 'package:note_app/note_pages/add_note.dart';
import 'package:note_app/note_pages/note_list.dart';
import 'package:note_app/utils/app_colors.dart';
import 'package:note_app/utils/app_str.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStr.notes, style: themeData.appBarTheme.titleTextStyle),
        backgroundColor: AppColors.appThemeColor,
      ),
      //Note list view
      body: NoteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) {
                return AddEditNote(title: null, description: null);
              },
            ),
          );
        },
        backgroundColor: AppColors.appThemeColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
