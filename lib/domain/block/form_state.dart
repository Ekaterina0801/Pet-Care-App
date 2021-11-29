part of 'form_block.dart';

@immutable
abstract class FormblockState {}

enum LoginandRegistrationState { Login, Regestration, Waiting }

//Регекс для электронной почты
RegExp _emailRegExp = RegExp(
  r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
);

class FormblockInitial extends FormblockState {
  //Вход
  InputWindow siginInusername;
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
    this.siginInusername = siginInusername ??
        InputWindow(
          title: "Логин",
          label: "Введите логин",
          validator: (s) {
            return ((s.length > 2) && (s.length < 10))
                ? null
                : "Некорректная длина логина";
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
          title: "Логин",
          label: "Придумайте логин",
          validator: (s) {
            return ((s.length > 2) && (s.length < 10))
                ? null
                : "Некорректная длина логина";
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
