import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/NotesPage/NotesWidget.dart';
import 'package:pet_care/repository/notesrepo.dart';

import 'Note.dart';
import 'NoteController.dart';


class NotesPage extends StatefulWidget{
  
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends StateMVC {
  NoteController _controller;
  _NotesPageState():super(NoteController()){
    _controller = controller as NoteController;
     //notifyListeners();
  }
  @override
  void initState() {
    super.initState();
    _controller.init();
  }
  final formKey = new GlobalKey<FormState>();
  String _body, _date;
  @override
  Widget build(BuildContext context) {
     final state = _controller.currentState;
     final noteField = TextField(
      maxLines: 10,
      onChanged: (value) {_body = value;_date = DateTime.now().toString();}, 
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Введите текст',
          hintStyle: TextStyle(color: Colors.white60),
        ),
    );
     if (state is NoteResultLoading) {
      // загрузка
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is NoteResultFailure) {
      // ошибка
      return Center(
        child: Text(
          state.error,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.red)
        ),
      );
    } else {   
      final notes = (state as NoteResultSuccess).notesList;
    return ListView(
      shrinkWrap: true,
      children: [
      TextButton(
         onPressed:(){ setState(() {
          //_displayNoteAdd(context, _body, _date);
           final formKey = new GlobalKey<FormState>();
      AlertDialog alert = AlertDialog(
      title: Text('Добавление заметки', 
      style:  GoogleFonts.comfortaa(
              color: Color.fromARGB(255, 0, 0, 0),
              fontStyle: FontStyle.normal,
              //fontWeight: FontWeight.w800, 
              fontSize: 18)
              ),
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
            setState((){addNote(_body, _date);
            //notifyListeners();
            Navigator.of(context).pop();
          });
          }),
      
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

    Future.delayed(Duration.zero, () async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
});
        });},
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Text("Добавить заметку",
          style:  GoogleFonts.comfortaa(
                color: Color.fromARGB(255, 0, 0, 0),
                fontStyle: FontStyle.normal,
                //fontWeight: FontWeight.w800, 
                fontSize: 18)
            ),
        )
        ),
      GridView.builder(
        shrinkWrap: true,
          physics: ScrollPhysics(),
        padding: EdgeInsets.all(15),
        itemCount: 
        notes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (BuildContext context, int index) => Container(
            child:  NotesWidget(notes[index])))

    ]);
  }
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
            //notifyListeners();
            Navigator.of(context).pop();
          },
        ),
      
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

    Future.delayed(Duration.zero, () async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
});
    
}
Future<Map<String,dynamic>> addNote(String text, String date) async{

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
