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
import 'AppBuilder.dart';
import 'Note.dart';
import 'NoteController.dart';

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
  @override
  Widget build(BuildContext context) {
      return AppBuilder(builder: (context) {
        return FutureBuilder(
              future: RepositoryNotes().getNotesByID(user.userid),
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

/*
//базовая страница
class BasePage2 extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget navigationbar;
  BasePage2({this.body, this.title, this.navigationbar = null});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
          shadowColor: Colors.grey,
          backgroundColor: Color.fromRGBO(255, 223, 142, 10),
          elevation: (title == 'Профиль') || (title == 'Сервис') ? 0 : 2,
          title: Text(title,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 24)),
        ),
        body: body,
        bottomNavigationBar: navigationbar,
        backgroundColor: Colors.white);
  }
}

//виджет навигационной панели
class HomePage2 extends StatefulWidget {
  @override
  _HomePageState2 createState() => _HomePageState2();
}

class _HomePageState2 extends State<HomePage2> {
  int currentindex = 0;
  final titles = [
    'Советы',
    'Сервис',
    'Календарь',
    'Записки',
    'Профиль',
  ];
  final children = [
    AdvicePage(),
    PetBoardingPage(),
    CalendarPage(),
    NotesPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BasePage2(
      title: titles[currentindex],
      body: children[currentindex],
      navigationbar: SalomonBottomBar(
        selectedItemColor: Colors.black,
        currentIndex: currentindex,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.book,
              size: 23,
            ),
            title: Text('Советы',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.location,
              size: 23,
            ),
            title: Text('Сервис',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.calendar,
              size: 23,
            ),
            title: Text('Календарь',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.pen,
              size: 23,
            ),
            title: Text('Записки',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.person,
              size: 23,
            ),
            title: Text('Профиль',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
        ],
      ),
    );
  }
}
*/