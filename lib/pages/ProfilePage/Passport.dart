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
        InfoWidget("Владелец", nameowner),
        InfoWidget("Дата рождения", dateb),
        //InfoWidget("Порода", breed),
        //InfoWidget("", info)
        InfoWidget("Прививки", vac),
        InfoWidget("Болезни", ill),
        // Container(
        //     // width: MediaQuery.of(context).size.width * 0.25,
        //     // height: MediaQuery.of(context).size.height * 0.05,
        //     padding: EdgeInsets.only(top: 15),
        //     margin: EdgeInsets.only(bottom: 5),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Color.fromRGBO(240, 240, 240, 1),
        //     ),
        //     child: Row(
        //       children: [
        //         Container(
        //             //padding: EdgeInsets.only(top: 30, bottom: 30),
        //             child: Text(
        //           'Владелец: $nameowner',
        //           textAlign: TextAlign.left,
        //           style: GoogleFonts.comfortaa(
        //               fontStyle: FontStyle.normal,
        //               fontWeight: FontWeight.w800,
        //               fontSize: 14),
        //         )),
        //       ],
        //     )),
        // Container(
        //     // width: MediaQuery.of(context).size.width * 0.25,
        //     // height: MediaQuery.of(context).size.height * 0.05,
        //     padding: EdgeInsets.only(top: 15),
        //     margin: EdgeInsets.only(top: 5, bottom: 5),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Color.fromRGBO(240, 240, 240, 1),
        //     ),
        //     child: Container(
        //         //padding: EdgeInsets.only(top: 35),
        //         child: Text(
        //       'Дата рождения: $dateb',
        //       textAlign: TextAlign.left,
        //       style: GoogleFonts.comfortaa(
        //           fontStyle: FontStyle.normal,
        //           fontWeight: FontWeight.w800,
        //           fontSize: 14),
        //     ))),
        // Container(
        //     // width: MediaQuery.of(context).size.width * 0.25,
        //     // height: MediaQuery.of(context).size.height * 0.05,
        //     padding: EdgeInsets.only(top: 15),
        //     margin: EdgeInsets.only(top: 5, bottom: 5),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Color.fromRGBO(240, 240, 240, 1),
        //     ),
        //     child: Container(
        //         //padding: EdgeInsets.only(top: 35),
        //         child: Text(
        //       'Порода: $breed',
        //       textAlign: TextAlign.left,
        //       style: GoogleFonts.comfortaa(
        //           fontStyle: FontStyle.normal,
        //           fontWeight: FontWeight.w800,
        //           fontSize: 14),
        //     ))),
        // Container(
        //     // width: MediaQuery.of(context).size.width * 0.25,
        //     // height: MediaQuery.of(context).size.height * 0.05,
        //     padding: EdgeInsets.only(top: 15),
        //     margin: EdgeInsets.only(top: 5, bottom: 5),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Color.fromRGBO(240, 240, 240, 1),
        //     ),
        //     child: Container(
        //         //padding: EdgeInsets.only(top: 35),
        //         child: Text(
        //       'Окрас: $color',
        //       textAlign: TextAlign.left,
        //       style: GoogleFonts.comfortaa(
        //           fontStyle: FontStyle.normal,
        //           fontWeight: FontWeight.w800,
        //           fontSize: 14),
        //     ))),
        // Container(
        //     //width: MediaQuery.of(context).size.width * 0.25,
        //     //height: MediaQuery.of(context).size.height * 0.05,
        //     padding: EdgeInsets.only(top: 15),
        //     margin: EdgeInsets.only(top: 5, bottom: 5),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Color.fromRGBO(240, 240, 240, 1),
        //     ),
        //     child: Container(
        //         //padding: EdgeInsets.only(top: 35),
        //         child: Text(
        //       'Вакцины и прививки: $vac',
        //       textAlign: TextAlign.left,
        //       style: GoogleFonts.comfortaa(
        //           fontStyle: FontStyle.normal,
        //           fontWeight: FontWeight.w800,
        //           fontSize: 14),
        //     ))),
        // Container(
        //     // width: MediaQuery.of(context).size.width * 0.25,
        //     // height: MediaQuery.of(context).size.height * 0.05,
        //     padding: EdgeInsets.only(top: 15),
        //     margin: EdgeInsets.only(top: 5, bottom: 5),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Color.fromRGBO(240, 240, 240, 1),
        //     ),
        //     child: Container(
        //         //padding: EdgeInsets.only(top: 35),
        //         child: Text(
        //       'Истрия болезней и операций: $ill',
        //       textAlign: TextAlign.left,
        //       style: GoogleFonts.comfortaa(
        //           fontStyle: FontStyle.normal,
        //           fontWeight: FontWeight.w800,
        //           fontSize: 14),
        //     )))
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
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
                subtitle: Text(
                  info,
                  style: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 14),
                ),
                isThreeLine: true,
              )),
          // child: RichText(
          //   text: TextSpan(children: <InlineSpan>[
          //     TextSpan(
          //         text: name + '\n',
          //         style: Theme.of(context).textTheme.bodyText2),
          //     TextSpan(
          //         text: facultyandcourse + '\n',
          //         style: Theme.of(context).textTheme.bodyText1),
          //   ]),
          // ),
        )
      ]),
    );
  }
}
