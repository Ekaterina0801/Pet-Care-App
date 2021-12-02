part of 'form_block.dart';

@immutable
abstract class FormblockEvent {}

class StartRegistration extends FormblockEvent {}

class StartLogin extends FormblockEvent {}

class StartWaiting extends FormblockEvent {}

class SendSignInForm extends FormblockEvent {
  final String email;
  final String password;

  SendSignInForm({this.email, this.password});
}

class SendSignUpForm extends FormblockEvent {
  final String username;
  final String password;
  final String email;

  SendSignUpForm({this.username, this.password, this.email});
}
