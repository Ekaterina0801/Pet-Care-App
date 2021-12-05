import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/pages/NotesPage/NotesWidget.dart';
import 'package:pet_care/repository/notesrepo.dart';

//Страница для отображения заметок
class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(15),
        itemCount: notes.length + 1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (BuildContext context, int index) => Container(
            child: index == notes.length
                ? Container(
                    child: Icon(
                    CupertinoIcons.add,
                    size: 50,
                  ))
                : NotesWidget(notes[index])));
  }
}
