import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../BasePage.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: "Изменить основные данные",
        body: Container(
            margin: EdgeInsets.all(25),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
              children: [
                Text('Введите фамилию:',
                    style: GoogleFonts.comfortaa(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16)),
                TextFormField(
                  autofocus: false,
                  //  onSaved: (value) => surname = value,
                ),
              ],
            )));
  }
}
