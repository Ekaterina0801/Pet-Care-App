import 'dart:convert';

import 'package:http/http.dart';
import 'package:pet_care/pages/NotesPage/Note.dart';
// импортируем http пакет
import 'package:http/http.dart' as http;

class RepositoryNotes {
  Future<List<Note>> getNotes() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Notes.json')));
    
    if (res.statusCode == 200) {
      //var rb = res.body;
      List<Note> list=[];
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
        Note a = Note.fromJson(ll[t]);
        //if(a.userID==)
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve notes.";
    }
  }
  }