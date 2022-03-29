//Класс для заметки
import 'dart:convert';

import 'dart:core';

class Note1
{
  int id;
  String body;
  String date;
  Note1({this.id,this.body,this.date});

  Map<String,dynamic> toMap()
  {
    return({
      "id":id,
      "body":body,
      "date":date
    });
  }
}

final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, number, title, description, time
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Note {
  final int id;
  final String title;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    this.title,
    this.description,
    this.createdTime,
  });

  Note copy({
    int id,
    String description,
    DateTime createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object> json) => Note(
        id: json[NoteFields.id] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
      };
}