import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/BasePage.dart';
import 'package:pet_care/pages/Registration/pages/register.dart';
import 'package:pet_care/pages/Registration/util/widgets.dart';
import 'package:pet_care/pages/providers/auth.dart';
import 'package:pet_care/pages/providers/userprovider.dart';
import 'package:provider/provider.dart';

import '../ValidatorsReg.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  String _email, _password;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final emailField = 

    TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration("Confirm password", Icons.email),
    );

    final passwordField = 
    TextFormField(
      autofocus: false,
      obscureText: true,
      validator: validatePassword,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Авторизация...Подождите")
      ],
    );
    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        /*
        TextButton(
          child: Text("Забыли пароль?",
              style: GoogleFonts.comfortaa(color: Color.fromARGB(255, 54, 28, 0),
                               fontWeight: FontWeight.w300, 
                               fontStyle: FontStyle.italic,
                               fontSize: 16)),
          onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),*/
        TextButton(
          //padding: EdgeInsets.only(left: 0.0),
          child: Text("Регистрация", 
          style: GoogleFonts.comfortaa(color: Color.fromARGB(255, 54, 28, 0),
                           fontWeight: FontWeight.w300,
                           fontStyle: FontStyle.italic,
                           fontSize: 18)),
          onPressed: () {
            //Navigator.pushNamed(context, '/register');
            Navigator.push(context, MaterialPageRoute(
  	builder: (context) => Register()
  ));
          },
        ),
      ],
    );

    var doLogin = () {
      final form = formKey.currentState;

      if (form.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
            auth.login(_email, _password);

        successfulMessage.then((response) {
          if (response['status']) {
            MyUser user = response['data'];
            //['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message']['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        print("form is invalid");
      }
    };

    return BasePage(
      title: "Авторизация",
      body: Scaffold(
        body: Container(
         padding: EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //child: Align(
                    //alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                    ],
                    //),
                  ),
                ),
                SizedBox(height: 12.0), // отступ (высота) между "Авторизация" и "почта"
                label("Электронная почта"),
                SizedBox(height: 5.0), // отступ (высота) между "почта" и белым контейнером "почта"
                emailField,
                SizedBox(height: 20.0), // отступ (высота) между желтым контейнером "почта" и белым контейнером "почта"
                label("Пароль"),
                SizedBox(height: 5.0), // отступ (высота) между "пароль" и белым контейнером "пароль"
                passwordField,
                SizedBox(height: 20.0), // отступ (высота) между желтым контейнером "вход" и белым контейнером "пароль"
                
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        longButtons("Вход", doLogin),
                      ],
                    ),
                    
                SizedBox(height: 5.0), // отступ (высота) между желтым контейнером "вход" и контейнерами "ЗП?" и "Регистрация"
                forgotLabel,
                SizedBox(height: 10,),
                Container(
                              child: Flexible(
                                child: Text(
                                  "Баг: при попытке ввести несуществующие в БД данные приложение ломается. Будет устранен", style:  GoogleFonts.comfortaa(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400, 
              fontSize: 12                  
              ),
                                  softWrap: true,),
                              ),
                            ),
              ],
            ),
          
        ),
      ),
    ));
  }
}