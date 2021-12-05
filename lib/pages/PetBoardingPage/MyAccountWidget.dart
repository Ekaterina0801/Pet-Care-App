import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/PetBoardingPage/Account.dart';

//виджет для отображения аккаунта на странице передержки
class MyAccountWidget extends StatelessWidget {
  final Account myaccount;
  MyAccountWidget(this.myaccount);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(color: Color.fromRGBO(255, 223, 142, 10), boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: const Offset(0.0, 0.0),
            spreadRadius: 0.0,
          )
        ]),
        child: Column(
          children: [
            Container(
              child: Avatar(
                name: myaccount.name,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(myaccount.name,
                  maxLines: 12,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 18)),
            ),
            SetAgreement(),
          ],
        ));
  }
}

class SetAgreement extends StatefulWidget {
  @override
  _SetAgreementState createState() => _SetAgreementState();
}

class _SetAgreementState extends State<SetAgreement> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Text("Согласие брать питомцев на передержку:",
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14)),
        ),
      ),
      Checkbox(
          checkColor: Colors.black,
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value;
            });
          }),
    ]);
  }
}
