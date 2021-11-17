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
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, i) {
            return AvatarBlock(profilespets[i].name, profilespets[i].photo);
          },
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
            MainInfoBlock("Возраст", "1 год 6 месяцев"),
            MainInfoBlock("Вес", "15 кг"),
            MainInfoBlock("Порода", "Корги"),
            MainInfoBlock("Пол", "Мужской"),
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
