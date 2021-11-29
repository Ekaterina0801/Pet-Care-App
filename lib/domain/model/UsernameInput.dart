import 'package:formz/formz.dart';

enum UsernameInputError { tolong, toshort }

class UsernameInput extends FormzInput<String, UsernameInputError> {
  static UsernameInputError errortext = UsernameInputError.tolong;
  //незаполненное поле
  const UsernameInput.pure() : super.pure('');
  //заполненное поле
  const UsernameInput.dirty({String value = ''}) : super.dirty(value);

  String getUsernameInputErrorText() {
    switch (errortext) {
      case UsernameInputError.tolong:
        return "Имя слишком длинное";
        break;
      case UsernameInputError.toshort:
        return "Имя слишком короткое";
        break;
      default:
        return "";
    }
  }

  //Валидатор
  @override
  UsernameInputError validator(String value) {
    if (value.length < 2) {
      errortext = UsernameInputError.toshort;
      return UsernameInputError.toshort;
    }
    if (value.length > 12) {
      errortext = UsernameInputError.tolong;
      return UsernameInputError.tolong;
    }
    return null;
  }
}
