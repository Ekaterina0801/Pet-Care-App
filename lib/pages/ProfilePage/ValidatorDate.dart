String validateDate(String value) {
  String _msg;
  RegExp regex = new RegExp(r'^(\d{2})[.|-|\|/](\d{2})[.|-|\|/](\d{4})$');
  var match = regex.firstMatch(value);
  if (value.isEmpty) {
    _msg = "Дата пустая";
  } else if (!regex.hasMatch(value)) {
    _msg = "Введите дату в формате ДД.ММ.ГГГГ";
  } else if (int.parse(match.group(2)) <= 0 || int.parse(match.group(2)) >= 13)
    _msg = "Введите месяц в диапазоне [01;12]";
  else if (int.parse(match.group(1)) <= 0 || int.parse(match.group(1)) >= 32)
    _msg = "Введите день в диапазоне [01;31]";
  else if (int.parse(match.group(3)) > DateTime.now().year ||
      (int.parse(match.group(3)) == DateTime.now().year &&
          int.parse(match.group(2)) > DateTime.now().month) ||
      (int.parse(match.group(3)) == DateTime.now().year &&
          int.parse(match.group(2)) == DateTime.now().month &&
          int.parse(match.group(1)) > DateTime.now().day))
    _msg = "Эта дата ещё не наступила";
  else if (int.parse(match.group(3)) <= 1995 &&
      int.parse(match.group(2)) <= 1 &&
      int.parse(match.group(1)) <= 1) _msg = "Введите дату больше 01.01.1995";
  return _msg;
}