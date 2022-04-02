//Класс для заметки
import 'dart:convert';

import 'dart:core';

class Note
{
  int id;
  int userID;
  String body;
  String date;
  Note({this.id,this.body,this.date,this.userID});

  Map<String,dynamic> toMap()
  {
    return({
      "id":id,
      "UserID":userID,
      "body":body,
      "date":date
    });
  }
factory Note.fromJson(Map<String, Object> json) => Note(
        id: json['Id'] as int,
        userID: json['UserID'],
        body: json['Text'] as String,
        date: json['Date'],
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'UserID':userID,
        'Text': body,
        'Date': date,
      };
}

abstract class NoteResult{}

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

 

