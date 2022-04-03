import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BasePage.dart';

List<String> photos = [
  "./assets/images/article_2.6.jpg",
  "./assets/images/article_1.2.jpg",
  "./assets/images/article_1.1.jpg"
];
List<String> date = ["01.02.2021", "01.04.2021", "12.05.2021"];
List<String> titles = [
  "Прививка от бешенства",
  "Другая важная прививка",
  "Третья важная прививка"
];

class VaccinationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Прививки',
      body: ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Padding(
            child: VaccinationsCard(photos[index], date[index], titles[index]),
            padding: EdgeInsets.symmetric(vertical: 20),
          );
        },
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

class VaccinationsCard extends StatelessWidget {
  String image;
  String date;
  String title;

  VaccinationsCard(String image, String date, String title) {
    this.image = image;
    this.date = date;
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color.fromRGBO(255, 223, 142, 100)),
        child: Column(
          children: [
            Image.asset(image),
            Container(
              margin: EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(date,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.comfortaa(
                        decoration: TextDecoration.underline,
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 15)),
              ),
            ),
            Container(
              //decoration:
              //    BoxDecoration(color: Color.fromRGBO(255, 223, 142, 100)),
              child: Row(
                children: [
                  Container(
                    //padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(18),
                    child: Text(title,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.comfortaa(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
