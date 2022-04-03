import 'package:meta/meta.dart';
import 'dart:async';
import 'model/User.dart';

User currentuser = null;

List<User> users = [
  User(username: "admin", password: "admin", email: "ds.katrin@mail.ru"),
  User(
      username: "ekaterina777",
      password: "123456",
      email: "ekaterina_dots@mail.ru")
];

//исключение с текстом
class TextException implements Exception {
  TextException({this.text}) : super();
  final String text;
}

//Неверный пароль
class IncorrectPasswordException extends TextException {
  IncorrectPasswordException() : super(text: "Неверный пароль");
}

class UserDontExistException extends TextException {
  UserDontExistException()
      : super(text: "Пользователя с такой почтой не существует");
}

//Пользователь с таким именем уже существует
class UserAlreadyExistExeption extends TextException {
  UserAlreadyExistExeption()
      : super(text: "Такая почта уже использована другим пользователем");
}

Future<void> LoginNamePassword({
  @required String email,
  @required String password,
}) async {
  User user = await TryToLogIn(
    email: email,
    password: password,
  );
  if (user != null) {
    if (user.password == password) {
      print("Успешно!");
      currentuser = user;
    } else {
      throw IncorrectPasswordException();
    }
  } else {
    throw UserDontExistException();
  }
}

Future<User> TryToLogIn({email, password}) =>
    Future.delayed(Duration(seconds: 1), () {
      return users
          .toList()
          .firstWhere((elm) => (elm.email == email), orElse: () => null);
    });

Future<bool> UserAlreadyExists({email}) =>
    Future.delayed(Duration(seconds: 3), () {
      return users.toList().where((elm) => (elm.email == email)).length > 0;
    });

Future<void> Registration({
  @required String username,
  @required String password,
  @required String email,
}) async {
  bool b = await UserAlreadyExists(email: email);
  if (b) {
    throw UserAlreadyExistExeption();
  } else {
    User user = User(username: username, password: password, email: email);
    users.add(user);
    currentuser = user;
  }
}
