import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/BasePage.dart';
import 'package:pet_care/pages/Registration/util/validators.dart';
import 'package:pet_care/pages/Registration/util/widgets.dart';
import 'package:pet_care/pages/providers/auth.dart';
import 'package:pet_care/pages/providers/userprovider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();

  String _email, _password, _firstname,_lastname;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final emailField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration("Введите email", Icons.email),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Введите пароль" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Подтвердите пароль", Icons.lock),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => value==_password ? "Ваш пароль не совпадает" : null,
      onSaved: (value) => _password = value,
      obscureText: true,
      decoration: buildInputDecoration("Введите пароль еще раз", Icons.lock),
    );

    final firstnameField = TextFormField(
      autofocus: false,
      validator: (value)=>value.isEmpty?"Имя пустое":null,
      onSaved: (value) => _firstname = value,
      decoration: buildInputDecoration("Введите имя", Icons.email),
    );

    final lastnameField = TextFormField(
      autofocus: false,
      validator: (value)=>value.isEmpty?"Фамилия пустая":null,
      onSaved: (value) => _lastname = value,
      decoration: buildInputDecoration("Введите фамилию", Icons.email),
    );
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text("Регистрация, пожалуйста, подождите")
      ],
    );

    var doRegister = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        auth.register(_email, _firstname,_lastname,_password).
         then((response) {
          if (response['status']) {
            MyUser user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            Flushbar(
              title: "Регистрация не удалась",
              message: response.toString(),
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Некорректная форма",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 10),
        ).show(context);
      }

    };

    return BasePage(
      title: "Регистрация",
      body: Scaffold(
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(40.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    label("Электронная почта"),
                    SizedBox(height: 5.0),
                    emailField,
                    SizedBox(height: 15.0),
                    label("Имя"),
                    SizedBox(height: 5.0),
                    firstnameField,
                    SizedBox(height: 15.0),
                    label("Фамилия"),
                    SizedBox(height: 5.0),
                    lastnameField,
                    SizedBox(height: 15.0),
                    label("Пароль"),
                    SizedBox(height: 10.0),
                    passwordField,
                    SizedBox(height: 15.0),
                    label("Подтвердите пароль"),
                    SizedBox(height: 10.0),
                    confirmPassword,
                    SizedBox(height: 20.0),
                    auth.loggedInStatus == Status.Authenticating
                        ? loading
                        : longButtons("Регистрация", doRegister),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}