import 'package:flutter/material.dart';
import 'package:pet_care/pages/ProfilePage/Pet.dart';

//ignore: must_be_immutable
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
                   style: Theme.of(context).copyWith().textTheme.bodyText1),
                TextFormField(
                  autofocus: false,
                  onSaved: (value) => pet.name = value,
                ),
                 Text('Введите вес питомца:',
                    style: Theme.of(context).copyWith().textTheme.bodyText1),
                TextFormField(
                  autofocus: false,
                  onSaved: (value) => pet.weight = value, 
                ),
              ],
            )));
  }
}
