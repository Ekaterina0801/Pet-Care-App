import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Passport extends StatelessWidget {
  final String nameowner;
  final String dateb;
  final String breed;
  final String color;
  final String vac;
  final String ill;
  Passport(
      this.nameowner, this.dateb, this.breed, this.color, this.vac, this.ill);

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.05,
            padding: EdgeInsets.only(top: 15),
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
            child: Container(
                //padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
              'Владелец: $nameowner',
              textAlign: TextAlign.left,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14),
            ))),
        Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.05,
            padding: EdgeInsets.only(top: 15),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
            child: Container(
                //padding: EdgeInsets.only(top: 35),
                child: Text(
              'Дата рождения: $dateb',
              textAlign: TextAlign.left,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14),
            ))),
        Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.05,
            padding: EdgeInsets.only(top: 15),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
            child: Container(
                //padding: EdgeInsets.only(top: 35),
                child: Text(
              'Порода: $breed',
              textAlign: TextAlign.left,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14),
            ))),
        Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.05,
            padding: EdgeInsets.only(top: 15),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
            child: Container(
                //padding: EdgeInsets.only(top: 35),
                child: Text(
              'Окрас: $color',
              textAlign: TextAlign.left,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14),
            ))),
        Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.05,
            padding: EdgeInsets.only(top: 15),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
            child: Container(
                //padding: EdgeInsets.only(top: 35),
                child: Text(
              'Вакцины и прививки: $vac',
              textAlign: TextAlign.left,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14),
            ))),
        Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.height * 0.05,
            padding: EdgeInsets.only(top: 15),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
            child: Container(
                //padding: EdgeInsets.only(top: 35),
                child: Text(
              'Истрия болезней и операций: $ill',
              textAlign: TextAlign.left,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14),
            )))
      ],
    );
  }
}
