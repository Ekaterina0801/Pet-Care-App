String validateText(String value) {
  String _msg;
  RegExp regex = new RegExp(
      r'^[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЭЮЯ][абвгдеёжзийклмнопрстуфхцчшъыьэюя]+$');
  var match = regex.firstMatch(value);
  if (value.isEmpty)
    _msg = "Введите имя";
  else if (!regex.hasMatch(value)) _msg = "Только символы кирилицы";
  return _msg;
}
