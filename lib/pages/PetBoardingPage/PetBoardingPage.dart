import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/PetBoardingPage/MyAccountWidget.dart';
import 'package:pet_care/repository/accounts.dart';

import 'AccountBlock.dart';
import 'SettingsService.dart';

class PetBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ScrollPhysics(),
      children: [
        Container(
            //padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: Color.fromRGBO(255, 223, 142, 10)),
            child: Column(children: [
              Container(
                child: Avatar(
                  name: accounts[0].name,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(accounts[0].name,
                    maxLines: 12,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 18)),
              ),
              //SetAgreement(),
              Container(
                  child: TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsService())),
                child: Text("Перейти к настройкам моего профиля для сервиса",
                    style: GoogleFonts.comfortaa(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 14)),
              )),
            ])),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 255,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: accounts.length,
            itemBuilder: (BuildContext context, int index) =>
                Container(child: AccountBlock(accounts[index]))),
      ],
    );
  }
}
