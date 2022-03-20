import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BasePage.dart';

List<String> photos = ["./assets/images/article_2.6.jpg","./assets/images/article_1.2.jpg","./assets/images/article_1.1.jpg"];
List<String> date = ["01.02.2021","01.04.2021","12.05.2021"];
List<String> titles = ["Укусил комарик", "Снова укусил комарик", "Болел живот из-за переедания"];

class VaccinationsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Прививки",
      body: ListView.builder(
        itemCount: photos.length,
  itemBuilder: (context, index) {
      return  VaccinationsCard(photos[index],date[index],titles[index]);
      
        
  }),
    );
  }
}

class VaccinationsCard extends StatelessWidget {
  String image;
  String date;
  String title;
  
  VaccinationsCard(String image, String date, String title)
  {
    this.image=image;
    this.date = date;
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Image.asset(image),
        Container(
          margin: EdgeInsets.all(20),
          child: Text(date,textAlign: TextAlign.left,
                    style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16)),
        ),
        Container(
          decoration: BoxDecoration(color: Color.fromRGBO(255, 223, 142, 100)),
          child: Row(
            children: [
              Container(
                child: Text(title,textAlign: TextAlign.left,
                          style: GoogleFonts.comfortaa(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                              fontSize: 16)),
              ),
            ],
          ),
        ),

      ],
    );
  }
}