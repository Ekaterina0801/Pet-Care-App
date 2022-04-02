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

  @override
  Widget build(BuildContext context) {
  
    return InkWell(
      onTap: () => _displayNote(context, widget.note.body),
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
                      widget.note.date,
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

_displayNote(BuildContext context,String text) {
    AlertDialog alert = AlertDialog(
      title: Text('Заметка', style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w900,
                fontSize: 16),),
      actions: [
        FlatButton(
          child: Text(
            'Ок',
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 16),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      content: Text(
         text,style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 16),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
