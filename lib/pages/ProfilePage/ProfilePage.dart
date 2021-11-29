import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/ProfilePage/AvatarBlock.dart';
import 'package:pet_care/pages/ProfilePage/MainInfoBlock.dart';
import 'package:pet_care/repository/profilespetsrepo.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            AvatarBlock(profilespets[1].name, profilespets[1].photo),
            Container(child:
                Icon(Icons.plus_one, size: 75),
                color: Color.fromRGBO(255, 225, 120, 1),
                height: 100,
                width: 100
            )
          ]
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: Text(
          "Основные данные",
          textAlign: TextAlign.center,
          style: GoogleFonts.comfortaa(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w800,
              fontSize: 20),
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainInfoBlock(
                "Возраст", "1 год 6 месяцев", Color.fromRGBO(245, 200, 125, 1)),
            MainInfoBlock("Вес", "15 кг", Colors.red),
            MainInfoBlock("Порода", "Корги", Colors.blue),
            MainInfoBlock("Пол", "Мужской", Colors.green),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: Text(
          "Паспорт питомца",
          textAlign: TextAlign.center,
          style: GoogleFonts.comfortaa(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w800,
              fontSize: 20),
        ),
      ),
    ]);
  }
}
