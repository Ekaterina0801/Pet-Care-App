import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/NotesPage/NotesWidget.dart';
import 'package:pet_care/pages/NotesPage/reponotes.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'package:provider/provider.dart';
import 'AppBuilder.dart';
import 'Note.dart';
import 'NoteController.dart';
// импортируем http пакет
import 'package:http/http.dart' as http;

/*
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
    
/*
RepositoryNotes().getNotes().then((result) {
   setState(() {
    notes = result;
  });
});*/
  }
  void update()
  {
    this.setState(() { });
  }
  final formKey = new GlobalKey<FormState>();
  String _body, _date;
  MyUser user;
  List<Note> notes=[];
  List<Note> mynotes=[];
  
  @override
  
  Widget build(BuildContext context) {
    
      return AppBuilder(builder: (context) {
        UserPreferences().getUser().then((result) {
   setState(() {
    user = result;
  });
});

Future<List<Note>> getNotes() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Notes.json')));
    print(res.body);
    final state = _controller.currentState;
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
        return FutureBuilder(
          
              future: getNotes(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      notes = snapshot.data;

                }
                return  ListView(shrinkWrap: true, children: [
                    FlatButton(
 height: 50,
 color: Colors.grey.shade200,
 onPressed: () {
                          _displayNoteAdd(context, _body, _date, user.userid, update);
                      },
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('+ Добавить заметку',
                              style: GoogleFonts.comfortaa(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16)))),
                  notes.length == 0
                      ? ListBody(children: [
                          Container(
                              height: window.physicalSize.height / 2 - 32),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Заметок пока нет",
                              style: GoogleFonts.comfortaa(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          )
                        ])
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.all(15),
                          itemCount: notes.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.2,
                          ),
                          itemBuilder: (BuildContext context, int index) =>
                              Container(child: NotesWidget(notes[index])))
                ]
        );
        }
        );
      }
      );
  }
}



  
  _displayNoteAdd(
      BuildContext context, String _body, String _date, int userID, void setState()) {
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
            addNote(_body, _date, userID);
            setState();
            //Navigator.pushNamed(context, '/home').then((_) => setState(() {}));
            //notifyListeners();
            Navigator.of(context).pop(true);
          },
        ),
      ],
      content: Container(
          padding: EdgeInsets.all(10),
          child: Form(
              key: formKey,
              child: TextField(
                maxLines: 10,
                onChanged: (value) {
                  _body = value;
                  _date = DateTime.now().toString();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите текст',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ))),
    );

    Future.delayed(Duration.zero, () async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    });
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
    Note note = Note(
        body: noteData['Text'], id: noteData['Id'], date: noteData['Date']);

    var result;
    if (response.request != null)
      result = {'status': true, 'message': 'Successfully add', 'data': note};
    else {
      result = {'status': false, 'message': 'Adding failed', 'data': null};
    }
    return result;
  }

*/
/*
class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}
class _NotesPageState extends StateMVC {
  NoteController _controller;
  _NotesPageState() : super(NoteController()) {
    _controller = controller as NoteController;
    //notifyListeners();
  }
  @override
   void initState() {
     super.initState();
     _controller.init();
     RepositoryNotes().getNotes().then((result) {
   setState(() {
    notes = result;
  });
});
     
   }

   final formKey = new GlobalKey<FormState>();
   String _body, _date;
   MyUser user;
   List<Note> notes;
   @override
   Widget build(BuildContext context) {
     Future<MyUser> getUserData() => UserPreferences().getUser();
     final state = _controller.currentState;
     if (state is NoteResultLoading) {
       // загрузка
       return Center(
         child: CircularProgressIndicator(),
       );
     } else if (state is NoteResultFailure) {
       // ошибка
       return Center(
         child: Text(state.error,
             textAlign: TextAlign.center,
             style: Theme.of(context)
                 .textTheme
                 .headline4
                 .copyWith(color: Colors.red)),
       );
     } else {
       final l = (state as NoteResultSuccess).notesList;
       return 
        FutureBuilder(
               future: getUserData(),
               builder: (context, snapshot) {
                 switch (snapshot.connectionState) {
                   case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                     if (snapshot.hasError)
                       return Text('Error: ${snapshot.error}');
                     else
                       user = snapshot.data;

                   //UserPreferences().removeUser();

                 }
                 List<Note> notes = [];
                 for (var i in l) {
                   if (i.userID == user.userid) notes.add(i);
                 }
                 return  ListView(shrinkWrap: true, children: [
                     FlatButton(
  height: 50,
  color: Colors.grey.shade200,
  onPressed: () {
                         setState(() {
                           //_displayNoteAdd(context, _body, _date);

 showDialog(
   context: context,
   builder: (context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
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
             addNote(_body, _date, user.userid);
             this.setState(() { });
             //Navigator.pushNamed(context, '/home').then((_) => setState(() {}));
             //notifyListeners();
             Navigator.of(context).pop(true);
           },
         ),
      ],
      content: Container(
          padding: EdgeInsets.all(10),
          child: Form(
              key: formKey,
              child: TextField(
                maxLines: 10,
                onChanged: (value) {
                  _body = value;
                  _date = DateTime.now().toString();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите текст',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ))),
    );
       },
     );
   },
 );
                          // _displayNoteAdd(context, _body, _date, user.userid);
                         }//
                         );
                       },
                       child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('+ Добавить заметку',
                              style: GoogleFonts.comfortaa(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16)))),
                  notes.length == 0
                      ? ListBody(children: [
                          Container(
                              height: window.physicalSize.height / 2 - 32),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Заметок пока нет",
                              style: GoogleFonts.comfortaa(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          )
                        ])
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.all(15),
                          itemCount: notes.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.2,
                           ),
                           itemBuilder: (BuildContext context, int index) =>
                               Container(child: NotesWidget(notes[index])))
                 ]);
               });
    
      
     }

   }



  _displayNoteAdd(
      BuildContext context, String _body, String _date, int userID) {
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
            addNote(_body, _date, userID);
            //Navigator.pushNamed(context, '/home').then((_) => setState(() {}));
            //notifyListeners();
            Navigator.of(context).pop(true);
          },
        ),
      ],
      content: Container(
          padding: EdgeInsets.all(10),
          child: Form(
              key: formKey,
              child: TextField(
                maxLines: 10,
                onChanged: (value) {
                  _body = value;
                  _date = DateTime.now().toString();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите текст',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ))),
    );
    Future.delayed(Duration.zero, () async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    });
  }
  Future<Map<String, dynamic>> addNote(
      String text, String date, int userID) async {
//Future<MyUser> getUserData() => UserPreferences().getUser();
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
    Note note = Note(
        body: noteData['Text'], id: noteData['Id'], date: noteData['Date']);
    var result;
    if (response.request != null)
      result = {'status': true, 'message': 'Successfully add', 'data': note};
    else {
      result = {'status': false, 'message': 'Adding failed', 'data': null};
     }
     return result;
   }
 }

 class DisplayAddNote extends StatelessWidget {
   int userid;
  String body, date;
  DisplayAddNote({this.userid,this.body,this.date});
final formKey = new GlobalKey<FormState>();
  //@override
  Future<Map<String, dynamic>> addNote(
      String text, String date, int userID) async {
//Future<MyUser> getUserData() => UserPreferences().getUser();
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
    Note note = Note(
        body: noteData['Text'], id: noteData['Id'], date: noteData['Date']);
    var result;
    if (response.request != null)
      result = {'status': true, 'message': 'Successfully add', 'data': note};
    else {
      result = {'status': false, 'message': 'Adding failed', 'data': null};
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
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
            addNote(body, date, userid);
            //Navigator.pushNamed(context, '/home').then((_) => setState(() {}));
            //notifyListeners();
            Navigator.pop(context);
          },
        ),
      ],
      content: Container(
          padding: EdgeInsets.all(10),
          child: Form(
              key: formKey,
              child: TextField(
                maxLines: 10,
                onChanged: (value) {
                  body = value;
                  date = DateTime.now().toString();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите текст',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ))),
    );
    Future.delayed(Duration.zero, () async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    });
  }
  }
*/

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}
class _NotesPageState extends StateMVC {
  NoteController _controller;
  _NotesPageState() : super(NoteController()) {
    _controller = controller as NoteController;
    //notifyListeners();
  }
  @override
  void initState() {
    super.initState();
    _controller.init();
    UserPreferences().getUser().then((result) {
   setState(() {
     user = result;
   });
 });

  }

   final formKey = new GlobalKey<FormState>();
   String _body, _date;
   MyUser user;
   List<Note> notes=[];
   List<Note> nnotes=[];

   @override

   Widget build(BuildContext context) {
       return AppBuilder(builder: (context) {
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
                      nnotes = snapshot.data;
                }
                notes=[];
                for(var n in nnotes)
                {
                    if(n.userID==user.userid)
                    notes.add(n);
                }
                return  ListView(shrinkWrap: true, children: [
                    FlatButton(
 height: 50,
 color: Colors.grey.shade200,
 onPressed: () {
                        setState(() {
showDialog(
  context: context,
  builder: (context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
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
             addNote(_body, _date, user.userid);
             this.setState(() { });
             Navigator.of(context).pop(true);
           },
         ),
      ],
      content: Container(
          padding: EdgeInsets.all(10),
          child: Form(
              key: formKey,
              child: TextField(
                maxLines: 10,
                onChanged: (value) {
                  _body = value;
                  _date = DateTime.now().toString();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите текст',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ))),
    );
      },
    );
  },
);     
               
}
                        );
                      },
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text('+ Добавить заметку',
                              style: GoogleFonts.comfortaa(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16)))),
                  notes.length == 0
                      ? ListBody(children: [
                          Container(
                              height: window.physicalSize.height / 2 - 32),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Заметок пока нет",
                              style: GoogleFonts.comfortaa(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          )
                        ])
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.all(15),
                          itemCount: notes.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.2,
                          ),
                          itemBuilder: (BuildContext context, int index) =>
                              Container(child: NotesWidget(notes[index])))
                 ]
         );
         }
         );
       }
       );
   }
}
  
  _displayNoteAdd(
      BuildContext context, String _body, String _date, int userID) {
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
            addNote(_body, _date, userID);
            //Navigator.pushNamed(context, '/home').then((_) => setState(() {}));
            //notifyListeners();
            Navigator.of(context).pop(true);
          },
        ),
      ],
      content: Container(
          padding: EdgeInsets.all(10),
          child: Form(
              key: formKey,
              child: TextField(
                maxLines: 10,
                onChanged: (value) {
                  _body = value;
                  _date = DateTime.now().toString();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите текст',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ))),
    );
    Future.delayed(Duration.zero, () async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    });
  }

  _displayNoteUpdate(
      BuildContext context, String oldbody, Note note) {
    final formKey = new GlobalKey<FormState>();
    var newbody=oldbody;
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
            RepositoryNotes().update(newbody,note);
            //Navigator.pushNamed(context, '/home').then((_) => setState(() {}));
            //notifyListeners();
            Navigator.of(context).pop(true);
          },
        ),
      ],
      content: Container(
          padding: EdgeInsets.all(10),
          child: Form(
              key: formKey,
              child: TextFormField(
              initialValue: oldbody,
                maxLines: 10,
                onChanged: (value) {
                  newbody = value;
                  //_date = DateTime.now().toString();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите текст',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ))),
    );
    Future.delayed(Duration.zero, () async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    });
  }

  Future<Map<String, dynamic>> addNote(
      String text, String date, int userID) async {
//Future<MyUser> getUserData() => UserPreferences().getUser();
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
    Note note = Note(
        body: noteData['Text'], id: noteData['Id'], date: noteData['Date']);
    var result;
    if (response.request != null)
      result = {'status': true, 'message': 'Successfully add', 'data': note};
    else {
      result = {'status': false, 'message': 'Adding failed', 'data': null};
    }
    return result;
  }

  
class DisplayAddNote extends StatelessWidget {
  int userid;
  String body, date;
  DisplayAddNote({this.userid,this.body,this.date});
final formKey = new GlobalKey<FormState>();
  //@override
  Future<Map<String, dynamic>> addNote(
      String text, String date, int userID) async {
//Future<MyUser> getUserData() => UserPreferences().getUser();
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
    Note note = Note(
        body: noteData['Text'], id: noteData['Id'], date: noteData['Date']);
    var result;
    if (response.request != null)
      result = {'status': true, 'message': 'Successfully add', 'data': note};
    else {
      result = {'status': false, 'message': 'Adding failed', 'data': null};
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
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
            addNote(body, date, userid);
            //Navigator.pushNamed(context, '/home').then((_) => setState(() {}));
            //notifyListeners();
            Navigator.pop(context);
          },
        ),
      ],
      content: Container(
          padding: EdgeInsets.all(10),
          child: Form(
              key: formKey,
              child: TextField(
                maxLines: 10,
                onChanged: (value) {
                  body = value;
                  date = DateTime.now().toString();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите текст',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ))),
    );
    Future.delayed(Duration.zero, () async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    });
  }
  }