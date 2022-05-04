import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/ProfilePage/AvatarBlock.dart';
import 'package:pet_care/pages/ProfilePage/MainInfoBlock.dart';
import 'package:pet_care/pages/ProfilePage/Passport.dart';
import 'package:pet_care/pages/ProfilePage/Pet.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'AddAnimal.dart';
// импортируем http пакет
import 'package:http/http.dart' as http;

/*
var h = window.physicalSize.height;
double FindCenterForPlus(double h) {
  double n;
  if (h / 2 > 125)
    n = h / 2 - 125;
  else
    n = h - 125;
  return n;
}
*/

DateTime dateToday =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
String ageToString(String date) {
  int dateBirthYear = int.parse(date.substring(6, 10));
  int dateBirthMonth = int.parse(date.substring(3, 5));

  var ageYears = (dateToday.year - dateBirthYear).round();
  var ageMonth = (dateToday.month - dateBirthMonth).round().abs();
  String years = "";
  String month = "";
  if (ageYears == 0)
    years = "";
  else if (ageYears == 1)
    years = "1 год";
  else if ((ageYears == 2) || (ageYears == 3) || (ageYears == 4))
    years = "$ageYears года";
  else
    years = "$ageYears лет";

  if (ageMonth == 0)
    month = "0 месяцев";
  else if (ageMonth == 1)
    month = "1 месяц";
  else if ((ageMonth == 2) || (ageMonth == 3) || (ageMonth == 4))
    month = "$ageMonth месяца";
  else
    month = "$ageMonth месяцев";

  String ageString = years + "\n" + month;
  return ageString;
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends StateMVC {
  PetController _controller;
  _ProfilePageState() : super(PetController()) {
    _controller = controller as PetController;
  }
  @override
  void initState() {
    super.initState();
    _controller.init();
   // allpets = getPets().then((value) => setState);
    UserPreferences().getUser().then((result) {
     
      setState(() {
        user = result;
        
      });
    });
    
  }

  void update() 
  {
    this.setState(() {});
  }

  final formKey = new GlobalKey<FormState>();
  MyUser user;
  Pet pet = new Pet();
  List<Pet> allpets = [];

  @override
  Widget build(BuildContext context) {
    //Future<MyUser> getUserData() => UserPreferences().getUser();
    final state = _controller.currentState;
    if (state is PetResultLoading) {
      // загрузка
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is PetResultFailure) {
      // ошибка
      return Center(
        child: Text(state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.red)),
      );
    } else {
      //final pets = (state as PetResultSuccess).petsList;
      return FutureBuilder(
          future: getPets(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  allpets = snapshot.data;
                //pet = new Pet();
                
                for (var i in allpets) {
                  if (i.userID == user.userid) {
                    pet = i;
                    break;
                  }
                }
                
                return pet.animal == null
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: Center(
                            child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                      height: 70,
                                      width: 70,
                                      child: FloatingActionButton(
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => AddAnimal(),
                                          ),
                                        ),
                                        child: Container(
                                            child: Icon(
                                              CupertinoIcons.add,
                                              size: 55,
                                              color: Colors.black,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    240, 240, 240, 1),
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                            height: 70,
                                            width: 70),
                                      )),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text(
                                      "Добавить нового питомца",
                                      style: GoogleFonts.comfortaa(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                      )
                    : ListView(children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 223, 142, 10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  offset: const Offset(0.0, 0.0),
                                  spreadRadius: 0.0,
                                )
                              ]),
                          padding: EdgeInsets.all(10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AvatarBlock(
                                    pet.name, 'assets/images/article_1.2.jpg'),
                              ]),
                        ),
                        Container(
                            alignment: Alignment.topRight,
                            child: Row(children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.topRight,
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
                                  alignment: Alignment.topRight,
                                  width: 30,
                                  child: FloatingActionButton(
                                      child: Icon(Icons.edit,
                                          color: Colors.grey, size: 20),
                                      backgroundColor: Colors.white,
                                      //onPressed: () => Navigator.push(context,
                                      //                      MaterialPageRoute(builder: (context) => ChangeInfoPage(pet))),
                                      onPressed: () {
                                        setState(() {
                                          _displayInfoPet(context, pet, update);
                                          update();
                                        });
                                        update();
                                      })),
                            ])),
                        Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MainInfoBlock(
                                  "Возраст",
                                  ageToString(pet.dateofbirthday),
                                  Color.fromRGBO(131, 184, 107, 80)),
                              MainInfoBlock(
                                "Вес",
                                pet.weight + " кг",
                                Color.fromRGBO(255, 223, 142, 10),
                              ),
                              MainInfoBlock("Пол", pet.gender,
                                  Color.fromRGBO(129, 181, 217, 90)),
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
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 0, top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Passport(
                                  user.firstname + " " + user.lastname,
                                  pet.dateofbirthday,
                                  pet.breed,
                                  pet.color,
                                  "Прививка от бешенства",
                                  "Нет"),
                            ],
                          ),
                        ),
                      ]);
            }
          });
    }
  }
}

_displayInfoPet(BuildContext context, Pet pet, void update()) {
  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  var newname = pet.name;
  var newweight = pet.weight;
  AlertDialog alert = AlertDialog(
      title: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Изменить основные данные',
              style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 16))),
      actions: [
        Column(
          children: [
            Form(
              key: formKey1,
              child: Column(
                children: [
                  addInfo('Введите имя питомца'),
                  TextFormField(
                    initialValue: pet.name,
                    autofocus: false,
                    onChanged: (value) => newname = value,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                ],
              ),
            ),
            Form(
                key: formKey2,
                child: Column(children: [
              
                  addInfo('Введите вес питомца'),
                  TextFormField(
                    autofocus: false,
                    initialValue: pet.weight,
                    onChanged: (value) => newweight = value,
                  ),
                ])),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            RaisedButton(
                color: Color.fromRGBO(255, 223, 142, 10),
                splashColor: Color.fromARGB(199, 240, 240, 240),
                onPressed: () {
                  updateName(newname, pet);
                  update();
                  updateWeight(newweight, pet);
                  update();
                  Navigator.pop(context, true);
                },
                child: Text('Принять',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 11)))
          ],
        ),
      ]);

  Future.delayed(Duration.zero, () async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  });
}

/*
//Диалоговое окно для изменения основных данных питомца
class ChangeInfo extends StatefulWidget {
  Pet pet;
  //void update;
  ChangeInfo(this.pet);

  @override
  State<ChangeInfo> createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  

  @override
  var newname= pet.name;
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Изменить основные данные',
              style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 16))),
      actions: [
       addInfo('Введите имя питомца'),
        TextFormField(
          initialValue: widget.pet.name,
          autofocus: false,
          onChanged: (value) => _changeName(value),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        addInfo('Введите вес питомца'),
        TextFormField(
          autofocus: false,
          initialValue: widget.pet.weight,
          onChanged: (value) => newweight = value,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        RaisedButton(
            color: Color.fromRGBO(255, 223, 142, 10),
            splashColor: Color.fromARGB(199, 240, 240, 240),
            onPressed: () => {
              updateName(, pet)
              this.setState(() {
              }),
            Navigator.pop(context, true)},
            child: Text('Принять',
                textAlign: TextAlign.left,
                style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 11)))
      ],
    );
  }
}
*/
Future<http.Response> updateName(String newtext, Pet pet) async {
  pet.name = newtext;
  return http.put(
    Uri.parse(Uri.encodeFull(
        'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Pets/' +
            pet.petidString +
            '.json')),
    body: jsonEncode(pet),
  );
}

Future<http.Response> updateWeight(String newtext, Pet pet) async {
  pet.weight = newtext;
  return http.put(
    Uri.parse(Uri.encodeFull(
        'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Pets/' +
            pet.petidString +
            '.json')),
    body: jsonEncode(pet),
  );
}

Widget addInfo(String text) {
  return Align(
      alignment: Alignment.bottomLeft,
      child: Text(text,
          style: GoogleFonts.comfortaa(
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w800,
              fontSize: 14)));
}
