import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/NotesPage/widgets/NotesWidget.dart';
import 'package:pet_care/pages/NotesPage/controllers/reponotes.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import '../AppBuilder.dart';
import '../Note.dart';
import '../controllers/NoteController.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends StateMVC {
  NoteController _controller;
  _NotesPageState() : super(NoteController()) {
    _controller = controller as NoteController;
  }
  @override
  void initState() {
    super.initState();
    _controller.init();
    UserPreferences().getUser().then(
      (result) {
        setState(
          () {
            user = result;
          },
        );
      },
    );
  }

  void update() {
    this.setState(() {});
  }

  final formKey = new GlobalKey<FormState>();
  String _body, _date;
  MyUser user;
  List<Note> notes = [];
  List<Note> allnotes = [];

  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      builder: (context) {
        return FutureBuilder(
          future: RepositoryNotes().getNotes(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  allnotes = snapshot.data;
            }
            notes = [];
            for (var n in allnotes) {
              if (n.userID == user.userid) notes.add(n);
            }
            return ListView(
              shrinkWrap: true,
              children: [
                ElevatedButton(
                  //height: 50,
                  style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade200,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _displayNoteAdd(
                            context, _body, _date, user.userid, update);
                        update();
                      },
                    );
                  },
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('+ Добавить заметку',
                      style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
                notes.length == 0
                    ? ListBody(
                        children: [
                          Container(
                              height: window.physicalSize.height / 2 - 32),
                          Align(
                            alignment: Alignment.center,
                            child: Text("Заметок пока нет",
                              style: Theme.of(context).textTheme.bodyText1),
                          )
                        ],
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.all(15),
                        itemCount: notes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1.2,
                        ),
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          child: NotesWidget(notes[index]),
                        ),
                      )
              ],
            );
          },
        );
      },
    );
  }
}

_displayNoteAdd(BuildContext context, String _body, String _date, int userID,
    void update()) {
  final formKey = new GlobalKey<FormState>();
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0),
     ),
    ),
    title: Container(
    child: Align(
    alignment: Alignment.bottomCenter,
    child:Text('Добавление заметки',
    style: Theme.of(context).copyWith().textTheme.headline2),
    ),),
    actions: [
         Container(
           height: 30,
           child: ElevatedButton(
            child: Text('Добавить',
            style: Theme.of(context).copyWith().textTheme.headline1),
            onPressed: () {
              if (formKey.currentState.validate()) {
                addNote(_body, _date, userID);
                update();
                Navigator.of(context).pop(true);
              }
            },
        ),
         ),
    ],
    
    content: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(43, 0, 0, 0),
            blurRadius: 5,
            offset: const Offset(0.0, 0.0),
            spreadRadius: 2.0,
            )],  
              color: Color.fromARGB(202, 242, 242, 242),
              border: Border.all(color:Color.fromARGB(202, 242, 242, 242)),
              borderRadius: BorderRadius.circular(10),),
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      child: Form(
        key: formKey,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => value.isEmpty ? "Поле пустое" : null,
          maxLines: 10,
          onChanged: (value) {
            _body = value;
            var now = DateTime.now();
            String formattedDate = DateFormat('dd-MM-yyyy  kk:mm').format(now);
            _date = formattedDate;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Введите текст',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    ),
  );
  Future.delayed(
    Duration.zero,
    () async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    },
  );
}

Future<Map<String, dynamic>> addNote(
    String text, String date, int userID) async {
  final Map<String, dynamic> noteData = {
    'Text': text,
    'Date': date,
    'Id': 1,
    'UserID': userID
  };
  var response = await post(
      Uri.parse(
          'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Notes.json'),
      body: json.encode(noteData));
  Note note =
      Note(body: noteData['Text'], id: noteData['Id'], date: noteData['Date']);
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': note};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
}
