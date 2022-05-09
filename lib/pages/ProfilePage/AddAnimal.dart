import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'package:pet_care/pages/Registration/util/widgets.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../BasePage.dart';
import '../Registration/ValidatorsReg.dart';
import 'ValidatorDate.dart';

String commaValid(String str) {
  RegExp exp = new RegExp(r',');
  String res = str.replaceAll(exp, '.');
  return res;
}

class AddAnimal extends StatefulWidget {
  @override
  State<AddAnimal> createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {
  String _animal, _name, _breed, _dateofbirthday, _gender, _color, _weight;
  int userID;
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Future<MyUser> getUserData() => UserPreferences().getUser();
    final animalField = SelectFormField(
      autofocus: false,
      items: [
        {'value': 'Кот/кошка', 'label': 'Кот/кошка'},
        {'value': 'Собака', 'label': 'Собака'},
        {'value': 'Черепаха', 'label': 'Черепаха'},
        {'value': 'Рыбка', 'label': 'Рыбка'},
      ],
      validator: (value) => value.isEmpty ? "Поле пустое" : null,
      onChanged: (value) => _animal = value,
      onSaved: (value) => _animal = value,
      decoration: buildInputDecoration("Вид питомца", Icons.pets),
    );
    final nameField = TextFormField(
        autofocus: false,
        //obscureText: true,
        validator: (value) => value.isEmpty ? "Введите имя питомца" : validateText(value),
        onSaved: (value) => _name = value,
        decoration: buildInputDecoration("Имя питомца",
          Icons.pets,
        ));

    final breedField = TextFormField(
        autofocus: false,
        //obscureText: true,
        validator:  (value) => value.isEmpty ? "Введите породу питомца" : validateText(value),
        onSaved: (value) => _breed = value,
        decoration: buildInputDecoration("Порода питомца",
          Icons.pets,
        ));

    final datebirthdayField = TextFormField(
        autofocus: false,
        //obscureText: true,
        validator: validateDate,
        onSaved: (value) {
          _dateofbirthday = value;
          petBirth = value;
        },
        decoration: buildInputDecoration(
          "Дата рождения питомца",
          Icons.pets,
        ));

    final genderField = SelectFormField(
      autofocus: false,
      items: [
        {'value': 'W', 'label': 'W'},
        {'value': 'M', 'label': 'M'},
      ],
      validator: (value) => value.isEmpty ? "Поле пустое" : null,
      onChanged: (value) => _gender = value,
      onSaved: (value) => _gender = value,
      decoration: buildInputDecoration("Пол питомца", Icons.pets),
    );

    final colorField = TextFormField(
        autofocus: false,
        //obscureText: true,
        validator:  (value) => value.isEmpty ? "Введите окрас" : validateText(value),
        onSaved: (value) => _color = value,
        decoration: buildInputDecoration("Окрас питомца",
          Icons.pets,
        ));

    final weightField = TextFormField(
        autofocus: false,
        //obscureText: true,
        validator: validateDigits,
        onSaved: (value) => _weight = value,
        decoration: buildInputDecoration("Вес питомца",
          Icons.pets,
        ));

    return BasePage(
        title: "Добавление питомца",
        body: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              //userID = snapshot.data.userID;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    userID = snapshot.data.userid;
              }
              return Form(
                key: formKey,
                child: ListView(children: [
                  SizedBox(height: 15.0),

                  Container(
                    padding:EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    //margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: Text("Вид питомца",
                        style: Theme.of(context).copyWith().textTheme.bodyText1),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                      padding:EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                      child: animalField),
                  SizedBox(height: 20.0),

                  Container(
                    padding:EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: Text("Имя питомца",
                        style: Theme.of(context).copyWith().textTheme.bodyText1),
                  ),

                  SizedBox(height: 5.0),
                  
                  Container(
                      padding:EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                      child: nameField),

                  SizedBox(height: 20.0),

                  Container(
                    padding:EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: Text("Порода питомца",
                        style: Theme.of(context).copyWith().textTheme.bodyText1),
                  ),

                  SizedBox(height: 5.0),

                  Container(
                      padding:EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                      child: breedField),

                  SizedBox(height: 20.0),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: Text("Дата рождения питомца",
                        style: Theme.of(context).copyWith().textTheme.bodyText1),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                      padding:EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                      child: datebirthdayField),
                  SizedBox(height: 20.0),

                  Container(
                    padding:EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: Text("Пол питомца",
                        style:Theme.of(context).copyWith().textTheme.bodyText1),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                      padding:EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                      child: genderField),
                  SizedBox(height: 20.0),

                  Container(
                    padding:EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: Text("Окрас питомца",
                        style:Theme.of(context).copyWith().textTheme.bodyText1),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                      child: colorField),
                  SizedBox(height: 20.0),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: Text("Вес питомца (кг)",
                        style:Theme.of(context).copyWith().textTheme.bodyText1),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                      padding:EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                      child: weightField),
                  SizedBox(height: 20.0),

                  //longButtons("Добавить", addPet()),
                  Container(
                      child: ElevatedButton(
                          child: Text('Добавить',
                            style: Theme.of(context) .copyWith().textTheme.bodyText1),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(255, 223, 142, 1))),
                          onPressed: () => {
                                if (formKey.currentState.validate())
                                  {
                                    formKey.currentState.save(),
                                    addPet(
                                        _animal,
                                        _name,
                                        _breed,
                                        _dateofbirthday,
                                        _gender,
                                        _color,
                                        _weight),
                                    Navigator.of(context).pop(),
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(0),
                                      ),
                                    ),
                                  }
                                else
                                  print("error validate"),
                              }))
                ]),
              );
            }));
  }
}

Future<Map<String, dynamic>> addPet(String animal, String name, String breed,
    String dateofbirthday, String gender, String color, String weight) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.get('userId');
  final Map<String, dynamic> petData = {
    'user_id': userId,
    'animal': animal,
    'name': name,
    'breed': breed,
    'date_of_birth': dateofbirthday,
    'gender': gender,
    'color': color,
    'weight': weight,
  };
  var response = await post(
      Uri.parse(
          'http://vadimivanov-001-site1.itempurl.com/Register/RegisterPet'),
      body: json.encode(petData),
      headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
      );
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': null};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
}
