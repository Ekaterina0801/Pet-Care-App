import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainInfoBlock extends StatelessWidget {
  final String title;
  final String info;
  final Color myColor;
  MainInfoBlock(this.title, this.info, this.myColor);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.2 + 30,
          height: 90,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: const Offset(1.0, 1.0),
                spreadRadius: 0.0,
              )
            ],
            borderRadius: BorderRadius.circular(10),
            color: myColor,
          ),
          child: Container(
              padding: EdgeInsets.only(top: 35),
              child: Text(
                info,
                textAlign: TextAlign.center,
                style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 14),
              )),
        ),
        Container(
            padding: EdgeInsets.all(5),
            child: Text(
              title,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14),
            ))
      ],
    );
  }
}
