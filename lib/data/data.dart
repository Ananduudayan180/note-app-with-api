import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:note_app/data/note_model/note_model.dart';
import 'package:note_app/data/url.dart';

abstract class ApiCalls {
  Future<NoteModel?> createNote(NoteModel value);
  // Future<List<NoteModel>> getAllNote();
  // Future<NoteModel?> updateNote(NoteModel value);
  // Future<void> deleteNote(String id);
}

class NoteDB implements ApiCalls {
  Dio dio = Dio();
  Url url = Url();

  NoteDB() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.plain,
    );
  }

  @override
  Future<NoteModel?> createNote(NoteModel note) async {
    try {
      final response = await dio.post(url.createNote, data: note.toJson());
      final result = await jsonDecode(response.data);
      return NoteModel.fromJson(result as Map<String, dynamic>);
    } on DioError catch (_) {
      return null;
    } catch (e) {
      return null;
    }
  }
}
