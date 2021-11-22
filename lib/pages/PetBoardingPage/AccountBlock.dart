import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Account.dart';

class AccountBlock extends StatelessWidget {
  final Account account;
  AccountBlock(this.account);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: const Offset(1.0, 1.0),
                  spreadRadius: 0.0,
                )
              ]),
          //padding: EdgeInsets.all(10),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(children: [
                    Avatar(
                      shape: AvatarShape.circle(50),
                      //shape: Shape.Circular,
                      name: account.name,
                      //numberLetters: 2,
                    ),
                  ])),
              Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 223, 142, 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 125,
                      width: 220,
                      padding: EdgeInsets.all(5),
                      child: Text(
                          'Имя: ' +
                              account.name,
                              // '\n' +
                              // 'E-mail: ' +
                              // account.email +
                              // '\n' +
                              // 'Район: ' +
                              // account.district +
                              // '\n' +
                              // 'Каких животных можно оставить: ' +
                              // account.kinfofpet,
                          maxLines: 9,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.comfortaa(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                              fontSize: 13)),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
