import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseasePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      
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
      child: ListTile(
        title: Text(title, textAlign: TextAlign.left,
                    style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16)),
        subtitle: Text("Начало: "+ start+"\n"+"Конец: "+ end),
      )
      
    );
  }
}