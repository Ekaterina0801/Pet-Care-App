//Класс для заметки

import 'dart:core';

class Note {
  int id;
  int userID;
  String body;
  String date;
  String noteid;
  Note({this.id, this.body, this.date, this.userID, this.noteid});

  Map<String, dynamic> toMap() {
    return (
      {
      "id": id,
      "UserID": userID,
      "body": body,
      "date": date,
      "nodeid": noteid
    }
    );
  }

  factory Note.fromJson(Map<String, Object> json) => Note(
      id: json['Id'] as int,
      userID: json['UserID'],
      body: json['Text'] as String,
      date: json['Date'],
      noteid: json['NoteID']
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'UserID': userID,
        'Text': body,
        'Date': date,
        'NoteID': "0",
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
