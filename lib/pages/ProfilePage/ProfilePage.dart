import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/ProfilePage/AvatarBlock.dart';
import 'package:pet_care/pages/ProfilePage/MainInfoBlock.dart';
import 'package:pet_care/pages/ProfilePage/Passport.dart';
import 'package:pet_care/repository/profilespetsrepo.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        padding: EdgeInsets.all(10),
        child: Row(children: [
          AvatarBlock(profilespets[1].name, profilespets[1].photo),
          Container(
              child: Icon(CupertinoIcons.add, size: 65),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 223, 142, 10),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              height: 100,
              width: 100)
        ]),
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
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            //boxShadow: BoxShadow(blurRadius: BorderRadius.all(10)),
            //color: Color.fromRGBO(240, 240, 240, 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainInfoBlock("Возраст", "1 год \n6 месяцев",
                Color.fromRGBO(208, 76, 49, 100)),
            MainInfoBlock(
              "Вес",
              "15 кг",
              Color.fromRGBO(255, 223, 142, 10),
            ),
            MainInfoBlock("Порода", "Корги", Color.fromRGBO(129, 181, 217, 60)),
            MainInfoBlock("Пол", "Мужской", Color.fromRGBO(131, 184, 107, 60)),
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
      Container(
        padding: EdgeInsets.only(left: 0, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Passport(
                "Екатерина",
                "30.01.2020",
                "Корги",
                "Рыжий",
                "Прививка от бешенства" +
                    "\n" +
                    "Прививка от второго бешенства",
                "Аллергия на говядину"),
          ],
        ),
      ),
    ]);
  }
}
