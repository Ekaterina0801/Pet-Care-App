import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarBlock extends StatelessWidget {
  final String name;
  final String photo;
  AvatarBlock(this.name, this.photo);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 80,
              backgroundImage: Image.asset(photo).image,
            ),
          ),
          Text(
            name,
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 14),
          ),
        ],
      ),
    );
  }
}
