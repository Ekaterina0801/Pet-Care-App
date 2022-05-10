import 'package:formz/formz.dart';

//Типы ошибок при вводе
enum PasswordInputError { toolong, tooshort }

/*Тип поля ввода имени наследуется от класса FormzInput
с указанием типа поля ввода и перечислимого типа ошибок ввода*/
class PasswordInput extends FormzInput<String, PasswordInputError> {
  static PasswordInputError errortext = PasswordInputError.toolong;
  //незаполненное поле
  const PasswordInput.pure() : super.pure('');
  //заполненное поле
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

  String getUsernameInputErrorText() {
    switch (errortext) {
      case PasswordInputError.toolong:
        return "Длина пароля должна быть меньше";
        break;
      case PasswordInputError.tooshort:
        return "Длина пароля должна быть больше";
        break;
      default:
        return "";
    }
  }

  //Validator
  @override
  PasswordInputError validator(String value) {
    if (value.length < 3) {
      errortext = PasswordInputError.tooshort;
      return PasswordInputError.tooshort;
    }
    if (value.length > 9) {
      errortext = PasswordInputError.toolong;
      return PasswordInputError.toolong;
    }
    return null;
  }
}
