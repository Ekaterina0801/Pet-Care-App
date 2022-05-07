import 'package:flutter/material.dart';

class AddInfo extends StatelessWidget {
  final String text;
  AddInfo(this.text);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        text,
        style: Theme.of(context).copyWith().textTheme.bodyText1,
      ),
    );
  }
}