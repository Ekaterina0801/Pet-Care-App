import 'package:pet_care/pages/ProfilePage/ProfilePage.dart';


String validateDate(String value) {
  String _msg;
  RegExp regex = new RegExp(r'^(\d{4})-(\d{2})-(\d{2})$');
  var match = regex.firstMatch(value);
  var year = int.parse(match.group(1));
  var day = int.parse(match.group(2));
  var month = int.parse(match.group(3));
  if (value.isEmpty) {
    _msg = "Дата пустая";
  } else if (!regex.hasMatch(value)) {
    _msg = "Введите дату в формате ГГГГ-ДД-ММ";
  } else if (month <= 0 || month >= 13)
    _msg = "Введите месяц в диапазоне [01;12]";
  else if ((day <= 0 ||
          day >= 32) &&
      (month == 1 ||
          month == 3 ||
          month == 5 ||
          month == 7 ||
          month == 8 ||
          month == 10 ||
          month == 12))
    _msg = "Введите день в диапазоне [01;31]";
  else if ((day <= 0 ||
          day >= 31) &&
      (month == 4 ||
          month == 6 ||
          month == 9 ||
          month == 11))
    _msg = "Введите день в диапазоне [01;30]";
  else if ((day <= 0 ||
          day >= 30) &&
      month == 2 &&
      year % 4 == 0)
    _msg = "Введите день в диапазоне [01;29]";
  else if ((day <= 0 ||
          day >= 29) &&
      month == 2 &&
      year % 4 != 0)
    _msg = "Введите день в диапазоне [01;28]";
  else if (year > DateTime.now().year ||
      (year == DateTime.now().year &&
          month > DateTime.now().month) ||
      (year == DateTime.now().year &&
          month == DateTime.now().month &&
          day > DateTime.now().day))
    _msg = "Эта дата ещё не наступила";
  else if (year <= 1995)
    _msg = "Введите дату позже 12.12.1995";
  return _msg;
}

String validateDatewithPet(String value) {
  String _msg;
  RegExp regex = new RegExp(r'^(\d{2})[.|-|\|/](\d{2})[.|-|\|/](\d{4})$');
  var match = regex.firstMatch(value);
   var year = int.parse(match.group(1));
  var day = int.parse(match.group(2));
  var month = int.parse(match.group(3));
  if (value.isEmpty) {
    _msg = "Дата пустая";
  } else if (!regex.hasMatch(value)) {
    _msg = "Введите дату в формате ДД.ММ.ГГГГ";
  } else if (month <= 0 || month >= 13)
    _msg = "Введите месяц в диапазоне [01;12]";
  else if ((day <= 0 ||
          day >= 32) &&
      (month == 1 ||
          month == 3 ||
          month == 5 ||
          month == 7 ||
          month == 8 ||
          month == 10 ||
          month == 12))
    _msg = "Введите день в диапазоне [01;31]";
  else if ((day <= 0 ||
          day >= 31) &&
      (month == 4 ||
          month == 6 ||
          month == 9 ||
          month == 11))
    _msg = "Введите день в диапазоне [01;30]";
  else if ((day <= 0 ||
          day >= 30) &&
      month == 2 &&
      year % 4 == 0)
    _msg = "Введите день в диапазоне [01;29]";
  else if ((day <= 0 ||
          day >= 29) &&
      month == 2 &&
      year % 4 != 0)
    _msg = "Введите день в диапазоне [01;28]";
  else if (year > DateTime.now().year ||
      (year == DateTime.now().year &&
          month > DateTime.now().month) ||
      (year == DateTime.now().year &&
          month == DateTime.now().month &&
          day > DateTime.now().day))
    _msg = "Эта дата ещё не наступила";
  else if ((year < int.parse(petBirth.substring(6, 10))) ||
      (year == int.parse(petBirth.substring(6, 10)) &&
          month < int.parse(petBirth.substring(3, 5))) ||
      (year == int.parse(petBirth.substring(6, 10)) &&
          month == int.parse(petBirth.substring(3, 5)) &&
          day < int.parse(petBirth.substring(0, 2))))
    _msg = "Эта дата была раньше рождения вашего питомца";
  return _msg;
}

String petBirth = "";
