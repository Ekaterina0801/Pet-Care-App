import 'package:meta/meta.dart';

//Класс пользователя
class User {
  const User({
    @required this.username,
    @required this.password,
    @required this.email,
  });
  final String username;
  final String password;
  final String email;

  static const empty = User(
    username: null,
    password: '',
    email: '',
  );
}
