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
  else if ((int.parse(match.group(1)) <= 0 ||
          int.parse(match.group(1)) >= 32) &&
      (int.parse(match.group(2)) == 1 ||
          int.parse(match.group(2)) == 3 ||
          int.parse(match.group(2)) == 5 ||
          int.parse(match.group(2)) == 7 ||
          int.parse(match.group(2)) == 8 ||
          int.parse(match.group(2)) == 10 ||
          int.parse(match.group(2)) == 12))
    _msg = "Введите день в диапазоне [01;31]";
  else if ((int.parse(match.group(1)) <= 0 ||
          int.parse(match.group(1)) >= 31) &&
      (int.parse(match.group(2)) == 4 ||
          int.parse(match.group(2)) == 6 ||
          int.parse(match.group(2)) == 9 ||
          int.parse(match.group(2)) == 11))
    _msg = "Введите день в диапазоне [01;30]";
  else if ((int.parse(match.group(1)) <= 0 ||
          int.parse(match.group(1)) >= 30) &&
      int.parse(match.group(2)) == 2 &&
      int.parse(match.group(3)) % 4 == 0)
    _msg = "Введите день в диапазоне [01;29]";
  else if ((int.parse(match.group(1)) <= 0 ||
          int.parse(match.group(1)) >= 29) &&
      int.parse(match.group(2)) == 2 &&
      int.parse(match.group(3)) % 4 != 0)
    _msg = "Введите день в диапазоне [01;28]";
  else if (int.parse(match.group(3)) > DateTime.now().year ||
      (int.parse(match.group(3)) == DateTime.now().year &&
          int.parse(match.group(2)) > DateTime.now().month) ||
      (int.parse(match.group(3)) == DateTime.now().year &&
          int.parse(match.group(2)) == DateTime.now().month &&
          int.parse(match.group(1)) > DateTime.now().day))
    _msg = "Эта дата ещё не наступила";
  else if (int.parse(match.group(3)) <= 1995)
    _msg = "Введите дату позже 12.12.1995";
  return _msg;
}

String validateDatewithPet(String value) {
  String _msg;
  RegExp regex = new RegExp(r'^(\d{2})[.|-|\|/](\d{2})[.|-|\|/](\d{4})$');
  var match = regex.firstMatch(value);
  if (value.isEmpty) {
    _msg = "Дата пустая";
  } else if (!regex.hasMatch(value)) {
    _msg = "Введите дату в формате ДД.ММ.ГГГГ";
  } else if (int.parse(match.group(2)) <= 0 || int.parse(match.group(2)) >= 13)
    _msg = "Введите месяц в диапазоне [01;12]";
  else if ((int.parse(match.group(1)) <= 0 ||
          int.parse(match.group(1)) >= 32) &&
      (int.parse(match.group(2)) == 1 ||
          int.parse(match.group(2)) == 3 ||
          int.parse(match.group(2)) == 5 ||
          int.parse(match.group(2)) == 7 ||
          int.parse(match.group(2)) == 8 ||
          int.parse(match.group(2)) == 10 ||
          int.parse(match.group(2)) == 12))
    _msg = "Введите день в диапазоне [01;31]";
  else if ((int.parse(match.group(1)) <= 0 ||
          int.parse(match.group(1)) >= 31) &&
      (int.parse(match.group(2)) == 4 ||
          int.parse(match.group(2)) == 6 ||
          int.parse(match.group(2)) == 9 ||
          int.parse(match.group(2)) == 11))
    _msg = "Введите день в диапазоне [01;30]";
  else if ((int.parse(match.group(1)) <= 0 ||
          int.parse(match.group(1)) >= 30) &&
      int.parse(match.group(2)) == 2 &&
      int.parse(match.group(3)) % 4 == 0)
    _msg = "Введите день в диапазоне [01;29]";
  else if ((int.parse(match.group(1)) <= 0 ||
          int.parse(match.group(1)) >= 29) &&
      int.parse(match.group(2)) == 2 &&
      int.parse(match.group(3)) % 4 != 0)
    _msg = "Введите день в диапазоне [01;28]";
  else if (int.parse(match.group(3)) > DateTime.now().year ||
      (int.parse(match.group(3)) == DateTime.now().year &&
          int.parse(match.group(2)) > DateTime.now().month) ||
      (int.parse(match.group(3)) == DateTime.now().year &&
          int.parse(match.group(2)) == DateTime.now().month &&
          int.parse(match.group(1)) > DateTime.now().day))
    _msg = "Эта дата ещё не наступила";
  else if ((int.parse(match.group(3)) < int.parse(petBirth.substring(6, 10))) ||
      (int.parse(match.group(3)) == int.parse(petBirth.substring(6, 10)) &&
          int.parse(match.group(2)) < int.parse(petBirth.substring(3, 5))) ||
      (int.parse(match.group(3)) == int.parse(petBirth.substring(6, 10)) &&
          int.parse(match.group(2)) == int.parse(petBirth.substring(3, 5)) &&
          int.parse(match.group(1)) < int.parse(petBirth.substring(0, 2))))
    _msg = "Эта дата была раньше рождения вашего питомца";
  return _msg;
}

String petBirth;