import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          //Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: const Offset(0.0, 0.0),
              spreadRadius: 2.0,
            )
          ]),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.baseline,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // decoration: BoxDecoration(
            //     shape: BoxShape.rectangle,
            //     color: Color.fromRGBO(255, 223, 142, 10),
            //     //Colors.white,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey,
            //         blurRadius: 4,
            //         offset: const Offset(0.0, 0.0),
            //         spreadRadius: 2.0,
            //       )
            //     ]),
            //decoration: BoxDecoration(color: Colors.grey),
            padding: EdgeInsets.all(10),
            child: Text(
              note.text,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
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
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
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
