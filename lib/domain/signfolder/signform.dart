// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/domain/block/form_block.dart';
import 'package:pet_care/domain/model/FormInput.dart';
import '../users.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FormblockBloc block = BlocProvider.of(context);
    return BlocConsumer<FormblockBloc, FormblockInitial>(
        listener: (context, state) {
      if (currentuser != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
      // ignore: missing_return
    }, builder: (context, state) {
      switch (state.currstare) {
        case LoginandRegistrationState.Login:
          return Column(
            children: [
              Column(
                children: [
                  state.errorrequest ? Text(state.errortext) : Container()
                ],
              ),
              InputWidget(
                controller: _usernamecontroller,
                title: state.siginInusername.title,
                lable: state.siginInusername.label,
                key1: state.siginInusername.key,
                validator: state.siginInusername.validator,
              ),
              InputWidget(
                controller: _passwordcontroller,
                title: state.siginInpassword.title,
                lable: state.siginInpassword.label,
                key1: state.siginInpassword.key,
                validator: state.siginInpassword.validator,
              ),
              TextButton(
                child: Text('Вход',
                    style: GoogleFonts.comfortaa(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 18)),
                onPressed: () {
                  block.add(SendSignInForm(
                      username: _usernamecontroller.text,
                      password: _passwordcontroller.text));
                },
              ),
              TextButton(
                  child: Text('Регистрация',
                      style: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 18)),
                  onPressed: () {
                    block.add(StartRegistration());
                  }),
            ],
          );
        case LoginandRegistrationState.Regestration:
          return Column(
            children: [
              Column(
                children: [
                  state.errorrequest ? Text(state.errortext) : Container()
                ],
              ),
              //Логин
              InputWidget(
                controller: _usernamecontroller,
                title: state.siginUpusername.title,
                lable: state.siginUpusername.label,
                key1: state.siginUpusername.key,
                validator: state.siginUpusername.validator,
              ),
              InputWidget(
                controller: _emailcontroller,
                title: state.siginUpemail.title,
                lable: state.siginUpemail.label,
                key1: state.siginUpemail.key,
                validator: state.siginUpemail.validator,
              ),
              //Пароль
              InputWidget(
                controller: _passwordcontroller,
                title: state.siginUppassword.title,
                lable: state.siginUppassword.label,
                key1: state.siginUppassword.key,
                validator: state.siginUppassword.validator,
              ),
              TextButton(
                  child: Text('Зарегистрироваться',
                      style: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 18)),
                  onPressed: () {
                    block.add(SendSignUpForm(
                        username: _usernamecontroller.text,
                        password: _passwordcontroller.text,
                        email: _emailcontroller.text));
                  }),
              TextButton(
                  child: Text('Вход',
                      style: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 18)),
                  onPressed: () {
                    block.add(StartLogin());
                  }),
            ],
          );
        case LoginandRegistrationState.Waiting:
          return _WaitingWidget();
        default:
      }
    });
  }
}

//Виджет для полей регистрации и входа
class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String lable;
  final ValidatorF validator;
  final GlobalKey<FormState> key1;

  InputWidget(
      {this.controller, this.title, this.lable, this.validator, this.key1});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text(title,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 18)),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: key1,
            child: TextFormField(
              cursorColor: Colors.black,
              controller: controller,
              validator: validator,
              decoration: InputDecoration(
                hoverColor: Colors.black,
                focusColor: Colors.black,
                fillColor: Colors.black,
                labelText: lable,
                helperText: '',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WaitingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        color: Colors.amber,
      ),
    );
  }
}
