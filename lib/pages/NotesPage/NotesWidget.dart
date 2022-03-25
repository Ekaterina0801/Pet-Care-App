import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/NotesPage/Note.dart';

class NotesWidget extends StatelessWidget {
  final Note1 note;
  NotesWidget(this.note);

  @override
  Widget build(BuildContext context) {
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
           
              note.body,
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
