part of 'form_block.dart';

@immutable
abstract class FormblockState {}

enum LoginandRegistrationState { Login, Regestration, Waiting }

//Регекс для электронной почты
RegExp _emailRegExp = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
);

//Регекс для имени
RegExp _usernameRegExp = RegExp(
  r'^[А-Я][а-я]*$',
);

class FormblockInitial extends FormblockState {
  //Вход
  InputWindow siginInemail;
  InputWindow siginInpassword;

  //Регистрация
  InputWindow siginUpusername;
  InputWindow siginUpemail;
  InputWindow siginUppassword;
  final String errortext;
  final bool errorrequest;
  final LoginandRegistrationState currstare;

  FormblockInitial({
    this.errortext = "",
    this.errorrequest = false,
    this.currstare = LoginandRegistrationState.Login,
  }) {
    this.siginInemail = siginInemail ??
        InputWindow(
          title: "Электронная почта",
          label: "Введите электронную почту",
          validator: (s) {
            return (_emailRegExp.hasMatch(s))
                ? null
                : "Некорректный формат E-mail";
          },
        );

    this.siginInpassword = siginInpassword ??
        InputWindow(
          title: "Пароль",
          label: "Введите пароль",
          validator: (s) {
            return ((s.length > 2) && (s.length < 10))
                ? null
                : "Некорректная длина пароля";
          },
        );

    //Поля регистрации
    this.siginUpusername = siginUpusername ??
        InputWindow(
          title: "Имя",
          label: "Введите имя и фамилию",
          validator: (s) {
            return (_usernameRegExp.hasMatch(s))
                ? null
                : "Имя должно быть на русском";
          },
        );

    this.siginUpemail = siginUpemail ??
        InputWindow(
          title: "Электронная почта",
          label: "Введите электронную почту",
          validator: (s) {
            return (_emailRegExp.hasMatch(s))
                ? null
                : "Некорректный формат E-mail";
          },
        );

    this.siginUppassword = siginUppassword ??
        InputWindow(
          title: "Пароль",
          label: "Придумайте пароль",
          validator: (s) {
            return ((s.length > 2) && (s.length < 10))
                ? null
                : "Некорректная длина пароля";
          },
        );
  }

  FormblockInitial copyWith({
    String errortext,
    bool errorrequest,
    LoginandRegistrationState currstate,
  }) {
    return FormblockInitial(
      errortext: errortext ?? this.errortext,
      errorrequest: errorrequest ?? this.errorrequest,
      currstare: currstare ?? this.currstare,
    );
  }
}
