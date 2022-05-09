import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/Registration/pages/register.dart';

import 'Registration/pages/login.dart';

class WelcomeScreen extends StatelessWidget {

@override
Widget build(BuildContext context) {
return Scaffold(
  
body: Column(children: [

  SizedBox(height: 130),

  Container(
    //padding: EdgeInsets.symmetric(horizontal: 150, vertical: 0),
    child: Image(
      image: AssetImage('assets/images/PetCare.png'),
      alignment: Alignment.bottomCenter
    ),
    width: 80,
    height: 80,
  ),

  SizedBox(height: 30),

  Container(
  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 0),
  child: Text('Добро пожаловать!', 
  textAlign: TextAlign.center, 
      style: Theme.of(context).copyWith().textTheme.headline2),
        ),

       SizedBox(height: 100),

       Container( 
        height: 35,
        child: ElevatedButton(onPressed: () {
          Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Register()
                        ),
                      );
          }, 
          child: Text('Создать аккаунт',
          textAlign: TextAlign.center, 
          style: Theme.of(context).copyWith().textTheme.headline1),
          //color: Color.fromRGBO(255, 223, 142, 1),
         // shape: RoundedRectangleBorder(
         // borderRadius: BorderRadius.all(Radius.circular(10))
         // ),
         // height: 45,
        ),
       ),

       SizedBox(height: 10),

       Container( 
        height: 35,
        //padding: EdgeInsets.symmetric(horizontal: 170, vertical: 0),
        child: ElevatedButton(onPressed: () {
         // Navigator.push()
         // Login();
         Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Login()
                        ),
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