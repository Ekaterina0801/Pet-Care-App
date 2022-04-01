//Класс для заметки
import 'dart:convert';

import 'dart:core';

class Note
{
  int id;
  String body;
  String date;
  Note({this.id,this.body,this.date});

  Map<String,dynamic> toMap()
  {
    return({
      "id":id,
      "body":body,
      "date":date
    });
  }
factory Note.fromJson(Map<String, Object> json) => Note(
        id: json['Id'] as int,
        body: json['Text'] as String,
        date: json['Date'],
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
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

 

