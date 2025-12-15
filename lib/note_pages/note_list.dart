import 'package:flutter/material.dart';
import 'package:note_app/utils/app_colors.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ListView.builder(
      itemBuilder: (context, index) {
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
                title: Text('Note ${index + 1}', style: textTheme.titleMedium),
                subtitle: Text(
                  'This is sample content for note',
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
      itemCount: 10,
    );
  }
}
