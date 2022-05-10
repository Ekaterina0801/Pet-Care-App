import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:pet_care/pages/NotesPage/Note.dart';
import 'package:http/http.dart' as http;

class NotesModel with ChangeNotifier {
  List<Note> notes =[];

  void getNotes() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Notes.json')));
    print(res.body);
    if (res.statusCode == 200) {
      //var rb = res.body;
      //List<Note> list=[];
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
        Note a = Note.fromJson(ll[t]);
        //if(a.userID==)
        notes.add(a);
      }
      //return list;
    } else {
      throw "Unable to retrieve notes.";
    }
  }
}