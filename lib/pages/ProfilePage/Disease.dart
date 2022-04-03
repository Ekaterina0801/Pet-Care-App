import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BasePage.dart';

List<String> disease = ["Укусил комарик","Болел живот от переедания"];
List<String> disease_start = ["12.06.2021", "15.08.2021"];
List<String> disease_end = ["12.06.2021","16.08.2021"];
class DiseasePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Болезни',
      body: ListView.builder(
        itemCount: disease.length,
  itemBuilder: (context, index) {
      return DiseaseCard(disease[index], disease_start[index],disease_end[index]);
  }),
    );
}
}

class DiseaseCard extends StatelessWidget {
  String title;
  String start;
  String end;

  DiseaseCard(String title, String start, String end)
  {
    this.title = title;
    this.start = start;
    this.end = end;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        color: Color.fromRGBO(240, 240, 240, 1),
              shadowColor: Colors.grey,
        child: ListTile(
          title: Text(title, textAlign: TextAlign.left,
                      style: GoogleFonts.comfortaa(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 16)),
          subtitle: Text("Начало: "+ start+"\n"+"Конец: "+ end),
        ),
      )
      
    );
  }
}