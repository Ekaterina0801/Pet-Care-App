import 'package:formz/formz.dart';

//Ошибки при вводе
enum UsernameInputError { invalid }

class UsernameInput extends FormzInput<String, UsernameInputError> {
  static UsernameInputError errortext = UsernameInputError.invalid;
  //незаполненное поле
  const UsernameInput.pure() : super.pure('');
  //заполненное поле
  const UsernameInput.dirty({String value = ''}) : super.dirty(value);

  String getUsernameInputErrorText() {
    switch (errortext) {
      case UsernameInputError.invalid:
        return "Неверный формат";
        break;
      default:
        return "";
    }
  }

  //Шаблон имени
  static final RegExp _usernameRegExp = RegExp(
    r'^[А-Я][а-я]*$',
  );

  //Валидатор
  @override
  UsernameInputError validator(String value) {
    errortext = UsernameInputError.invalid;
    return _usernameRegExp.hasMatch(value) ? null : UsernameInputError.invalid;
  }
}
