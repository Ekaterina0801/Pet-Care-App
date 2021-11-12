import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainInfoBlock extends StatelessWidget {
  final String title;
  final String info;
  MainInfoBlock(this.title, this.info);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.25 - 10,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(245, 201, 123, 1),
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
