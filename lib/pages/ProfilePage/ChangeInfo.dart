import 'package:flutter/material.dart';
import 'package:pet_care/pages/ProfilePage/Pet.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeInfoPage extends StatelessWidget {
  Pet pet;
  ChangeInfoPage(this.pet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //title: "Изменить основные данные",
        body: Container(
            margin: EdgeInsets.all(25),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
              children: [
                Text('Введите имя питомца:',
                    style: GoogleFonts.comfortaa(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16)),
                TextFormField(
                  autofocus: false,
                  onSaved: (value) => pet.name = value,
                ),
                 Text('Введите вес питомца:',
                    style: GoogleFonts.comfortaa(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16)),
                TextFormField(
                  autofocus: false,
                  onSaved: (value) => pet.weight = value, 
                ),
              ],
            )));
  }
}
