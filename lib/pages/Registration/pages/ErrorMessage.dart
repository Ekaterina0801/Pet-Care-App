import 'package:flutter/material.dart';

class MessageErrorLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        title: Text('Ошибка авторизации', style: Theme.of(context).textTheme.bodyText2),
        content: Text(
          'Неверный пароль или такого пользователя не существует',
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