String validateText(String value) {
  String _msg;
  RegExp regex = new RegExp(r'^[А-Я][а-я]+$');
  var match = regex.firstMatch(value);
  if (value.isEmpty)
    _msg = "Введите имя";
  else if (!regex.hasMatch(value))
    _msg = "Введите символами кириллицы с заглавной буквы";
  return _msg;
}

String validateEmail(String value) {
  String _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = "Введите электронную почту";
  } else if (!regex.hasMatch(value)) {
    _msg = "Введите электронную почту корректно";
  }
  return _msg;
}

String validatePassword(String value) {
  String _msg;
  RegExp regex = new RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
  if (value.isEmpty) {
    _msg = "Введите пароль";
  } else if (!regex.hasMatch(value)) 
   _msg = "Пароль должен содержать символы латиницы в обоих регистрах \n и не менее 1 цифры и спецсимвола";
  return _msg;
}
