import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/NotesPage/Note.dart';
import 'package:pet_care/pages/NotesPage/reponotes.dart';


class NotesWidget extends StatefulWidget {
  final Note note;
  NotesWidget(this.note);

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  void update()
  {
    this.setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
  
    return InkWell(
      onTap: () => _displayNoteUpdate(context, widget.note.body,widget.note,update),
      child: Container(
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
                softWrap: true,
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
                      widget.note.date.toString().substring(0,10),
                      style: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
 _displayNoteUpdate(
      BuildContext context, String oldbody, Note note, void update()) {
    final formKey = new GlobalKey<FormState>();
    var newbody=oldbody;
    AlertDialog alert = AlertDialog(
      title: Text('Редактирование'),
      actions: [
        
        FlatButton(
          child: Text(
            'Применить',
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 14),
          ),
          onPressed: () {
            RepositoryNotes().update(newbody,note);
            update();
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
