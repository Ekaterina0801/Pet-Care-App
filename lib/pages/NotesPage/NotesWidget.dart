import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:pet_care/pages/NotesPage/Note.dart';
import 'package:pet_care/pages/Registration/util/appurl.dart';

class NotesWidget extends StatefulWidget {
  final Note note;
  NotesWidget(this.note);

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  final formKey = new GlobalKey<FormState>();
  String _body, _date;
  @override
  Widget build(BuildContext context) {
    final noteField = TextField(
      maxLines: 10,
      onChanged: (value) {_body = value;_date = DateTime.now().toString();}, 
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Введите текст',
          hintStyle: TextStyle(color: Colors.white60),
        ),
    );
    return Container(
      //height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          shape: BoxShape.rectangle,
          color: Color.fromRGBO(251, 236, 192, 10),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(198, 191, 172, 1),
              blurRadius: 0.5,
              offset: const Offset(0.0, 0.0),
              spreadRadius: 2.0,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
           
              widget.note.body,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
            ),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(),
                  child: Text(
                    widget.note.date,
         
                    style: GoogleFonts.comfortaa(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 14),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(CupertinoIcons.pen),
                    onPressed: () => _displayNoteAdd(context,_body,_date),
                    ))
            ],
          ),
        ],
      ),
    );
  }
}
_displayNoteAdd(BuildContext context,String _body, String _date)
{
      final formKey = new GlobalKey<FormState>();
      AlertDialog alert = AlertDialog(
      title: Text('Добавление заметки'),
      actions: [
        FlatButton(
          child: Text(
            'Добавить',
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 14),
          ),
          onPressed: () {
            addNote(_body, _date);
            Navigator.of(context).pop();
          },
        )
      ],
      content: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: TextField(
      maxLines: 10,
      onChanged: (value) {_body = value;_date = DateTime.now().toString();}, 
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Введите текст',
          hintStyle: TextStyle(color: Colors.white60),
        ),
    )
        )
      ),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
}
Future<Map<String,dynamic>> addNote(String text, String date) async {

  final Map<String,dynamic> noteData = 
  {
    'Text':text,
    'Date':date,
    'Id':1,
  };

  var response = await post(Uri.parse('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Notes.json'),
  body: json.encode(noteData));
  Note note = Note(
    body: noteData['Text'],
    id:noteData['Id'],
    date: noteData['Date']
  );

  var result;
  if (response.request!=null)
    result = {
        'status': true,
        'message': 'Successfully add',
        'data': note
      };
    else{
      result = {
        'status': false,
        'message': 'Adding failed',
        'data': null
      };
    }
    return result;
}

