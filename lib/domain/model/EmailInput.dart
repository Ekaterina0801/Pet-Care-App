import 'package:formz/formz.dart';

//Ошибки при вводе
enum EmailInputError { invalid }

class EmailInput extends FormzInput<String, EmailInputError> {
  static EmailInputError errortext = EmailInputError.invalid;
  //незаполненное поле
  const EmailInput.pure() : super.pure('');
  //заполненное поле
  const EmailInput.dirty({String value = ''}) : super.dirty(value);

  String getUsernameInputErrorText() {
    switch (errortext) {
      case EmailInputError.invalid:
        return "Неверный формат E-mail";
        break;
      default:
        return "";
    }
  }

  //Шаблон электронной почты
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  //Валидатор
  @override
  EmailInputError validator(String value) {
    errortext = EmailInputError.invalid;
    return _emailRegExp.hasMatch(value) ? null : EmailInputError.invalid;
  }
}
