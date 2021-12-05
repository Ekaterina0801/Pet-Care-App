import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/NotesPage/Note.dart';

class NotesWidget extends StatelessWidget {
  final Note note;
  NotesWidget(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Color.fromRGBO(255, 223, 142, 10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
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
              note.text,
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
                    note.date,
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
                  child: Icon(CupertinoIcons.pen))
            ],
          ),
        ],
      ),
    );
  }
}
