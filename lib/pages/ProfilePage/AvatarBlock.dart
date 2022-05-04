import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarBlock extends StatefulWidget {
  final String name;
  final String photo;
  AvatarBlock(this.name, this.photo);

  @override
  State<AvatarBlock> createState() => _AvatarBlockState();
}

class _AvatarBlockState extends State<AvatarBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 80,
              backgroundImage: Image.asset(widget.photo).image,
            ),
          ),
          Text(
            widget.name,
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
