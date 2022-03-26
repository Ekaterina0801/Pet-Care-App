import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

MaterialButton longButtons(String title, Function fun,
    {Color color: const Color.fromRGBO(255, 223, 142, 10), Color textColor: Colors.black}
    //Alignment.bottomCenter
    ) {
  return MaterialButton(
    onPressed: fun,
    //textTheme: ButtonTextTheme.normal,
    textColor: textColor,
    color: color,
    child: SizedBox(
      //child: Align(
      //alignment: Alignment.bottomCenter,
      //width: double.infinity,
      child: Text(
        title,
        style: GoogleFonts.comfortaa(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400, 
              fontSize: 20                  
              ),
        textAlign: TextAlign.center, 
        ),
      //), 
    ),
    height: 45,
    //minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

label(String title) => Text(title,style: GoogleFonts.comfortaa(
              color: Color.fromARGB(255, 0, 0, 0),
              fontStyle: FontStyle.normal,
              //fontWeight: FontWeight.w400, 
              fontSize: 14                  
              ),
              );

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}