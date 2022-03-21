import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

MaterialButton longButtons(String title, Function fun,
    {Color color: const Color.fromRGBO(255, 223, 142, 10), Color textColor: Colors.black}
    ) {
  return MaterialButton(
    onPressed: fun,
    //textTheme: ButtonTextTheme.normal,
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: GoogleFonts.comfortaa(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600, 
              fontSize: 20                  
              ),
        textAlign: TextAlign.center,              
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

label(String title) => Text(title);

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}