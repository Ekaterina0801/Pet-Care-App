import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {

@override
Widget build(BuildContext context) {
var child;
return Scaffold(
  
body: Column(children: [

  Container(
    padding: EdgeInsets.all(50),
    child: Image(
      image: AssetImage('assets/images/PetCare.png'),
      alignment: Alignment.bottomCenter
    ),
    width: 80,
    height: 80,
  ),

  Container(
  padding: EdgeInsets.all(100), 
  child: Text('Добро пожаловать!', 
  textAlign: TextAlign.center, 
  style: GoogleFonts.comfortaa(
         color: Colors.black,
         fontStyle: FontStyle.normal,
         fontWeight: FontWeight.w800,
         fontSize: 24),
         ),
        ),

       Container( 
        child: FlatButton(onPressed: () {}, 
          child: Text('Создать аккаунт',
          textAlign: TextAlign.center, 
          style: GoogleFonts.comfortaa(
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w800,
          fontSize: 18),
          ),
          color: Color.fromRGBO(255, 223, 142, 1),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          height: 45,
        ),
       ),

       SizedBox(height: 5),

       Container( 
        child: FlatButton(onPressed: () {}, 
          child: Text('У меня уже есть аккаунт',
          textAlign: TextAlign.center, 
          style: GoogleFonts.comfortaa(
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w800,
          fontSize: 18),
          ),
          color: Color.fromRGBO(255, 223, 142, 1), shape: 
          RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          height: 45,
        ),
       )
        /*child: Container(
                decoration: BoxDecoration(
                color: Color.fromRGBO(255, 223, 142, 1),
                borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
                )*/
                
                /*child: Align(
                  alignment: Alignment.center,
                  child: Container(*/
                    
          /*child: FlatButton(onPressed: () {}, 
          child: Text('Создать аккаунт',
          textAlign: TextAlign.center, 
          style: GoogleFonts.comfortaa(
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w800,
          fontSize: 18),)*/

      ]),
    );
  }
}