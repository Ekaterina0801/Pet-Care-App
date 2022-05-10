String validateText(String value) {
  String _msg;
  RegExp regex = new RegExp(r'^[А-ЯЁ][а-яё]+$');
  var match = regex.firstMatch(value);
  if (value.isEmpty)
    _msg = "Введите текст";
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

String validateReal(String value) {
  String _msg;
  RegExp regex = new RegExp(
      r'^((\d+\.\d+)|(\d+))$');
  if (value.isEmpty) {
    _msg = "Введите вес в кг";
  } else if (!regex.hasMatch(value)) 
   _msg = "Допускаются только цифры и точка";
  return _msg;
}

String validateDigits(String value) {
  String _msg;
  RegExp regex = new RegExp(
      r'^(\d+)$');
  if (value.isEmpty) {
    _msg = "Введите число";
  } else if (!regex.hasMatch(value)) 
   _msg = "Можно ввести только целое число";
  return _msg;
}





