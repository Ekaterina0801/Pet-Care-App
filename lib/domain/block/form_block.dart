import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pet_care/domain/model/FormInput.dart';
import 'dart:async';
import '../users.dart';

part 'form_state.dart';
part 'form_event.dart';

class FormblockBloc extends Bloc<FormblockEvent, FormblockInitial> {
  FormblockBloc() : super(FormblockInitial());

  @override
  Stream<FormblockInitial> mapEventToState(
    FormblockEvent event,
  ) async* {
    if (event is StartLogin) {
      yield FormblockInitial(currstare: LoginandRegistrationState.Login);
    }
    if (event is StartRegistration) {
      yield FormblockInitial(currstare: LoginandRegistrationState.Regestration);
    }
    if (event is StartWaiting) {
      yield FormblockInitial(currstare: LoginandRegistrationState.Waiting);
    }

    if (event is SendSignInForm) {
      if (state.siginInemail.key.currentState.validate() &&
          state.siginInpassword.key.currentState.validate()) {
        try {
          yield FormblockInitial(currstare: LoginandRegistrationState.Waiting);
          await LoginNamePassword(email: event.email, password: event.password);
          yield FormblockInitial(currstare: LoginandRegistrationState.Login);
        } on TextException catch (e) {
          yield FormblockInitial(
            errorrequest: true,
            errortext: e.text,
            currstare: LoginandRegistrationState.Login,
          );
        }
      }
    }
    if (event is SendSignUpForm) {
      if (state.siginUpusername.key.currentState.validate() &&
          state.siginUppassword.key.currentState.validate() &&
          state.siginUpemail.key.currentState.validate()) {
        try {
          yield FormblockInitial(currstare: LoginandRegistrationState.Waiting);
          await Registration(
              username: event.username,
              password: event.password,
              email: event.email);
          yield FormblockInitial(
              currstare: LoginandRegistrationState.Regestration);
        } on TextException catch (e) {
          yield FormblockInitial(
            errorrequest: true,
            errortext: e.text,
            currstare: LoginandRegistrationState.Regestration,
          );
        }
      }
    }
  }
}
