import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        title: Text('Ошибка', style: Theme.of(context).textTheme.bodyText2),
        content: Text(
          'Ошибка добавления события: некоторые из полей ввода данных оказались пустыми. Пожалуйста, попробуйте снова',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          ElevatedButton(
            child: Text('Ок'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}