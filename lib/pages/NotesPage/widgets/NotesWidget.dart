import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/NotesPage/Note.dart';
import 'package:pet_care/pages/NotesPage/controllers/reponotes.dart';

import '../../BasePage.dart';

class NotesWidget extends StatefulWidget {
  final Note note;
  NotesWidget(this.note);

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  void update() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _displayNoteUpdate(context, widget.note.body, widget.note, update);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          shape: BoxShape.rectangle,
          color: Color.fromARGB(255, 251, 236, 192),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(159, 198, 191, 172),
              blurRadius: 0.5,
              offset: const Offset(0.0, 0.0),
              spreadRadius: 2.0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(widget.note.body,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).copyWith().textTheme.bodyText1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  child: Container(
                    padding: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(),
                    child: Text(
                      widget.note.date,
                      style: Theme.of(context).copyWith().textTheme.bodyText1),
                  ),
                ),

                Container(
                  child: IconButton(
                    onPressed: () {
                      deleteNote(widget.note, update);
                      update();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomePage(3),
                        ),
                      );
                    },
                    icon: Icon(Icons.delete, size: 16),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void deleteNote(Note note, void update()) {
  RepositoryNotes().delete(note);
  update();
  
}

_displayNoteUpdate(
    BuildContext context, String oldbody, Note note, void update()) {
  final formKey = new GlobalKey<FormState>();
  var newbody = oldbody;
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(0.0),),
    ),
    title: Text('Редактирование'),
    actions: [
         Container(
           height: 3,
           child: ElevatedButton(
            child: Text('Применить',
              style: Theme.of(context).copyWith().textTheme.bodyText1),
            onPressed: () {
              if (formKey.currentState.validate()) {
                RepositoryNotes().update(newbody, note);
                update();
              }
              Navigator.of(context).pop(true);
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
