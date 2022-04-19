import 'dart:convert';

import 'package:http/http.dart';
import 'package:pet_care/dommain/myuser.dart';
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
        a.noteid=t;
        //if(a.userID==)
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve notes.";
    }
  }

  Future<http.Response> update(String newtext,Note note) async {
    note.body=newtext;
    return http.put(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Notes/'+note.noteid+'.json')),
    body: jsonEncode(note
      //'Date':note.date,
      //'NoteID':note.noteid,
      //'Id':note.id,

    ),);
    
    
  }

  Future<List<Note>> getNotesByID(int userid) async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Notes.json')));
    if (res.statusCode == 200) {
      //var rb = res.body;
      List<Note> list=[];
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
        Note a = Note.fromJson(ll[t]);
        //if(a.userID==)
        if(a.userID==userid)
          list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve notes.";
    }
  }
  }