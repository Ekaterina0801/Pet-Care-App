//Класс для заметки

import 'dart:core';

class Note {
  String body;
  String date;
  int noteId;

  Note({this.noteId, this.body, this.date});

  Map<String, dynamic> toMap() {
    return (
      {
      "textOfNote": body,
      "date": date,
      "nodeId": noteId
    }
    );
  }
  //List<Note> notesList()
  factory Note.fromJson(Map<String, Object> json) => Note(
      body: json['textOfNote'] as String,
      date: json['date'],
      noteId: json['noteId']
      );

  Map<String, dynamic> toJson() => {
        'textOfNote': body,
        'date': date,
        'noteId': noteId,
      };
}

abstract class NoteResult {}

//указатель на успешный запрос
class NoteResultSuccess extends NoteResult {
  final List<Note> notesList;
  NoteResultSuccess(this.notesList);
}

// произошла ошибка
class NoteResultFailure extends NoteResult {
  final String error;
  NoteResultFailure(this.error);
}

// загрузка данных
class NoteResultLoading extends NoteResult {
  NoteResultLoading();
}
