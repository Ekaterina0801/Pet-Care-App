import 'package:flutter/material.dart';

typedef Callback = void Function(String);
typedef ValidatorF = String Function(String);

class InputWindow {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final String label;
  final String title;
  final ValidatorF validator;
  bool isvalidate = false;
  InputWindow({this.label, this.title, this.validator, text = ""}) {}

  InputWindow copyWith({String text}) {
    label:
    this.label;
    titel:
    this.title;
    validator:
    this.validator;
  }
}
