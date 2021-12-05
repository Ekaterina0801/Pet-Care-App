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
        InfoWidget("Владелец: ", nameowner),
        InfoWidget("Порода:", breed),
        InfoWidget("Дата рождения питомца: ", dateb),
        InfoWidget("Прививки:", vac),
        InfoWidget("Болезни: ", ill),
      ],
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String title;
  final String info;
  InfoWidget(this.title, this.info);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(children: [
        Expanded(
          child: Card(
              //color: Colors.blue,
              color: Color.fromRGBO(240, 240, 240, 1),
              shadowColor: Colors.grey,
              child: ListTile(
                title: Text(
                  title,
                  style: GoogleFonts.comfortaa(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w900,
                      fontSize: 17),
                ),
                subtitle: Text(
                  info,
                  style: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 15),
                ),
                leading: Icon(Icons.edit),
                isThreeLine: true,
              )),
        )
      ]),
    );
  }
}
