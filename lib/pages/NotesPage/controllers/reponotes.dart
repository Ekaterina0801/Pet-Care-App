import 'dart:convert';
import 'package:http/http.dart';
import 'package:pet_care/pages/NotesPage/Note.dart';
// импортируем http пакет
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dommain/myuser.dart';

class RepositoryNotes {
  Future<Map<String, dynamic>> update(String newtext, Note note) async {
    final Map<String, dynamic> noteData = {
    'what':"note",  
    'id': note.noteId,
    'new_value': newtext,
  };
    var response = await http.post(
      Uri.parse(Uri.encodeFull(
          'http://vadimivanov-001-site1.itempurl.com/Update/UpdateInformation')),
      body: jsonEncode(noteData),
      headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
    );
    var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': note};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
  }

  Future<http.Response> delete(Note note) async {
    int noteid = note.noteId;
    var response =  http.delete(
      Uri.parse(
        Uri.encodeFull(
            'http://vadimivanov-001-site1.itempurl.com/Delete/DeleteNote?note_id=$noteid'),
      ),
      body: jsonEncode(note),
      headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
    );
    return response;
  }

  Future<List<Note>> getNotesByID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.get('userId');
    Response res = await http.get(
      Uri.parse(
        Uri.encodeFull(
            'http://vadimivanov-001-site1.itempurl.com/Load/LoadNotes?user_id=$userId'),
      ),
    );

    if (res.statusCode == 200) {
      List<Note> list = [];
      var ll = jsonDecode(res.body);
      for (var t in ll) {
        Note a = Note.fromJson(t);
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve notes.";
    }
  }
}
