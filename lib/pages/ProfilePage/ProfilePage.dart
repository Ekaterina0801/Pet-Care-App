import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/BasePage.dart';
import 'package:pet_care/pages/ProfilePage/AvatarBlock.dart';
import 'package:pet_care/pages/ProfilePage/ChangeInfo.dart';
import 'package:pet_care/pages/ProfilePage/MainInfoBlock.dart';
import 'package:pet_care/pages/ProfilePage/Passport.dart';
import 'package:pet_care/pages/ProfilePage/Pet.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'package:pet_care/pages/providers/auth.dart';
import 'package:pet_care/pages/providers/userprovider.dart';
import 'package:pet_care/repository/profilespetsrepo.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'AddAnimal.dart';

DateTime dateToday =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
String AgeToString(String date) {
  int dateBirth_year = int.parse(date.substring(6,10));
  int dateBirth_month = int.parse(date.substring(3,5));

  String age_years = (dateToday.year - dateBirth_year).round().toString();
  String age_month =
      (dateToday.month - dateBirth_month).round().abs().toString();
  String age_string = "${age_years} года \n${age_month} месяцев";
  return age_string;
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
  }

  final formKey = new GlobalKey<FormState>();
  MyUser user;
  Pet pet;

  @override
  Widget build(BuildContext context) {
    Future<MyUser> getUserData() => UserPreferences().getUser();
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
      final pets = (state as PetResultSuccess).petsList;
      //UserPreferences().getUser().then((value) => user=value)
      //Future<MyUser> getUserData() => UserPreferences().getUser();
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => UserProvider()),
          ],
          child: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      user = snapshot.data;

                    //final pets = (state as PetResultSuccess).petsList;
                    pet = Pet(
                        petID: 1,
                        userID: user.userid,
                        animal: "-",
                        name: "-",
                        breed: "-",
                        dateofbirthday: "-",
                        gender: "-",
                        weight: 0,
                        color: "-");
                    for (var i in pets) {
                      if (i.userID == user.userid) {
                        pet = i;
                        break;
                      }
                    }
                    return pet.weight == 0
                        ? Center(
                            child: Column(
                            children: [
                              Container(
                                  height: window.physicalSize.height / 2 - 168),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                        height: 130,
                                        width: 130,
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
                                                size: 110,
                                                color: Colors.black,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      240, 240, 240, 1),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100))),
                                              height: 135,
                                              width: 140),
                                        )),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Text(
                                        "Добавить нового питомца",
                                        style: GoogleFonts.comfortaa(
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              /*   Container(
              child: TextButton(
                onPressed: () => 
                Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddAnimal(
                           
                          ),
                        ),
                      ),
                child: Text("Добавить данные о питомце"),
              ),
            )*/
                            ],
                          ))
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
                                        pet.name, profilespets[1].photo),
                                    /*
              Column(
                children: [
                  Container(
                      child: Icon(
                        CupertinoIcons.add,
                        size: 55,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 240, 240, 1),
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      height: 70,
                      width: 70),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Добавить",
                      style: GoogleFonts.comfortaa(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 12),
                    ),
                  )
                ],
              )*/
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
                                        // onPressed: () => Navigator.push(context,
                                        //                      MaterialPageRoute(builder: (context) => ChangeInfo(pet))),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  opaque: false,
                                                  pageBuilder:
                                                      (BuildContext context, _,
                                                              __) =>
                                                          ChangeInfo(pet)));
                                        },
                                      )),
                                ])),
                            Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              padding: EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MainInfoBlock("Возраст", AgeToString(pet.dateofbirthday),
                                      Color.fromRGBO(131, 184, 107, 80)),
                                  MainInfoBlock(
                                    "Вес",
                                    pet.weight.toString(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
              }));
    }
  }
}

//Диалоговое окно для изменения основных данных питомца
class ChangeInfo extends StatefulWidget {
  Pet pet;
  ChangeInfo(this.pet);

  @override
  State<ChangeInfo> createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  _changeName(String value) {
    setState(() => widget.pet.name = value);
  }

  @override
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
        Align(
            alignment: Alignment.bottomLeft,
            child: Text('Введите имя питомца:',
                style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 14))),
        TextFormField(
          autofocus: false,
          onChanged: (value) => _changeName(value),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Align(
            alignment: Alignment.bottomLeft,
            child: Text('Введите вес питомца:',
                style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 14))),
        TextFormField(
          autofocus: false,
          onChanged: (value) => widget.pet.weight = int.parse(value),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        RaisedButton(
            color: Color.fromRGBO(255, 223, 142, 10),
            splashColor: Color.fromARGB(199, 240, 240, 240),
            onPressed: () => {(Navigator.pop(context, true))},
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
