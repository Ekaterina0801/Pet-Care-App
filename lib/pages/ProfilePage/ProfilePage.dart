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
String AgeToString(String date) {
  int dateBirth_year = int.parse(date.substring(6, 10));
  int dateBirth_month = int.parse(date.substring(3, 5));

  var age_years = (dateToday.year - dateBirth_year).round();
  var age_month = (dateToday.month - dateBirth_month).round().abs();
  String years = "";
  String month = "";
  if (age_years == 0)
    years = "";
  else if (age_years == 1)
    years = "1 год";
  else if ((age_years == 2) || (age_years == 3) || (age_years == 4))
    years = "${age_years} года";
  else
    years = "${age_years} лет";

  if (age_month == 0)
    month = "0 месяцев";
  else if (age_month == 1)
    month = "1 месяц";
  else if ((age_month == 2) || (age_month == 3) || (age_month == 4))
    month = "${age_month} месяца";
  else
    month = "${age_month} месяцев";

  String age_string = years + "\n" + month;
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
      return  FutureBuilder(
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
                    pet = new Pet();
                    for (var i in pets) {
                      if (i.userID == user.userid) {
                        pet = i;
                        break;
                      }
                    }
                    return pet.animal==null
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
                                                    borderRadius:
                                                        BorderRadius.all(
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
                                  MainInfoBlock(
                                      "Возраст",
                                      AgeToString(pet.dateofbirthday),
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
              });
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
       addInfo('Введите имя питомца'),
        TextFormField(
          autofocus: false,
          onChanged: (value) => _changeName(value),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        addInfo('Введите вес питомца'),
        TextFormField(
          autofocus: false,
          onChanged: (value) => widget.pet.weight = value,
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

Widget addInfo(String text)
{
  return Align(
            alignment: Alignment.bottomLeft,
            child: Text(text,
                style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 14)));
}