import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/BasePage.dart';
import 'package:pet_care/pages/Registration/util/validators.dart';
import 'package:pet_care/pages/Registration/util/widgets.dart';
import 'package:pet_care/pages/providers/auth.dart';
import 'package:pet_care/pages/providers/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';
//import 'package:select_form_field/select_form_field.dart';

//(\d+)[\.|\-](\d+)[\.|\-](\d+)\s(.*)
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();

  String _email,
      _password,
      _firstname,
      _lastname,
      _district;
     bool _ready;

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
      validator: (value) =>
          value == _password ? "Ваш пароль не совпадает" : null,
      onSaved: (value) => _password = value,
      obscureText: true,
      decoration: buildInputDecoration("Введите пароль еще раз", Icons.lock),
    );

    final firstnameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Имя пустое" : null,
      onSaved: (value) => _firstname = value,
      decoration: buildInputDecoration("Введите имя", Icons.person_rounded),
    );

    final lastnameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Фамилия пустая" : null,
      onSaved: (value) => _lastname = value,
      decoration: buildInputDecoration("Введите фамилию", Icons.person_rounded),
    );

    final districtField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Район пустой" : null,
      onSaved: (value) => _district = value,
      decoration: buildInputDecoration("Введите район", Icons.place),
    );

    final readyField = SelectFormField(
      autofocus: false,
      items: [
        {'value': 'Да', 'label': 'Да'},
        {'value': 'Нет', 'label': 'Нет'}
      ],
      validator: (value) => value.isEmpty ? "Поле пустое" : null,
      onChanged: (value) => value=="Да"?_ready = true:_ready=false,
      onSaved: (value) => value=="Да"?_ready = true:_ready=false,
      decoration: buildInputDecoration(
          "Готовы брать питомцев на передержку? (true/false)", Icons.home),
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
        auth
            .register(_email, _firstname, _lastname, _password, _district,
                 _ready)
            .then((response) {
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
                    label("Район"),
                    SizedBox(height: 10.0),
                    districtField,
                    SizedBox(height: 15.0),
                    //label("Стоимость передержки"),
                    //SizedBox(height: 10.0),
                    //priceField,
                    //SizedBox(height: 15.0),
                   //SizedBox(height: 15.0),
                    //label("Виды животных"),
                    //SizedBox(height: 10.0),
                    //typeField,
                    //SizedBox(height: 15.0),
                    label("Готовы брать на передержку?"),
                    SizedBox(height: 10.0),
                    readyField,
                    SizedBox(height: 15.0),
                    auth.loggedInStatus == Status.Authenticating
                        ? loading
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              longButtons("Создать профиль", doRegister),
                            ],
                          ),
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
