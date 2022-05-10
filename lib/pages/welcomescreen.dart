import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/Registration/pages/register.dart';

import 'Registration/pages/login.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SizedBox(height: 130),
        
        Container(
          child: Image(
              image: AssetImage('assets/images/PetCare.png'),
              alignment: Alignment.bottomCenter),
          width: 120,
          height: 120,
        ),

        SizedBox(height: 30),

        Center(
          child: Text('Добро пожаловать!',
              textAlign: TextAlign.center,
              style: Theme.of(context).copyWith().textTheme.headline2),
        ),
        
        SizedBox(height: 100),

        Container(
          margin: EdgeInsets.only(top:10,left:30,right:30),
          //height: 35,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
            child: Text('Создать аккаунт',
                textAlign: TextAlign.center,
                style: Theme.of(context).copyWith().textTheme.headline1),
          ),
        ),

        SizedBox(height: 10),

        Container(
          margin: EdgeInsets.only(top:10,left:30,right:30),
          //padding: EdgeInsets.symmetric(horizontal: 170, vertical: 0),
          child: ElevatedButton(
            onPressed: () {
              // Navigator.push()
              // Login();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Text('У меня уже есть аккаунт',
                textAlign: TextAlign.center,
                style: Theme.of(context).copyWith().textTheme.headline1),
            // color: Color.fromRGBO(255, 223, 142, 1), shape:
            //RoundedRectangleBorder(
            // borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        // )
      ]),
    );
  }
}
