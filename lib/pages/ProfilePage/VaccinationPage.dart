import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/ProfilePage/vaccinationsrepo.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'package:select_form_field/select_form_field.dart';

import '../BasePage.dart';

import '../NotesPage/AppBuilder.dart';
import '../Registration/util/widgets.dart';
import 'Vaccination.dart';
import 'VaccinationCard.dart';
import 'VaccinationController.dart';

List<String> photos = [
  "./assets/images/article_2.6.jpg",
  "./assets/images/article_1.2.jpg",
  "./assets/images/article_1.1.jpg"
];

class VaccinationPage extends StatefulWidget 
{
  @override
  _VaccinationPageState createState() => _VaccinationPageState();
}

class _VaccinationPageState extends StateMVC {
  VaccinationController _controller;
  _VaccinationPageState() : super(VaccinationController()) {
    _controller = controller as VaccinationController;
  }
  @override
  void initState() {
    super.initState();
    _controller.init();
    UserPreferences().getUser().then((result) {
      setState(() {
        user = result;
      });
    });
  }

  void update() {
    this.setState(() {});
  }

  String type, date;
  bool revaccination = false;
  MyUser user;
  List<Vaccination> vacc = [];
  final formKey = new GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Прививки',
      body: AppBuilder(
        builder: (context) {
          return FutureBuilder(
            future: RepositoryVaccinations().getvacc(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    vacc = snapshot.data;
              }
              
              return ListView(
                shrinkWrap: true,
                children: [
                  ElevatedButton(
                    //height: 50,
                    //color: Colors.grey.shade200,
                    style: ElevatedButton.styleFrom(
                    primary: Colors.grey.shade200,
                  ),
                    onPressed: () {
                      setState(
                        () {
                          final formKey = new GlobalKey<FormState>();
                          AlertDialog alert = AlertDialog(
                            title: Container(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text('Добавление прививки',
                                style: Theme.of(context).copyWith().textTheme.headline2),
                                  /*style: GoogleFonts.comfortaa(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),*/
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                child: Text(
                                  'Добавить',
                                  style: GoogleFonts.comfortaa(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14),
                                ),
                                //color: Color.fromRGBO(255, 223, 142, 1),
                                //shape: RoundedRectangleBorder(
                                //   borderRadius:
                                //      BorderRadius.all(Radius.circular(10))),
                                // height: 45,
                                onPressed: () {
                                  setState(
                                    () {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                        addVaccination(date,type,"",revaccination);
                                      }
                                      this.setState(() {});
                                    },
                                  );
                                  Navigator.of(context).pop(true);

                                    //Navigator.pushNamed(context, "/notes");
                                  },
                                ),
                            
                            ],

                            content: Container(
                              margin: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                              child: Column(
                                children: [
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Align(
                                                  alignment:Alignment.bottomLeft,
                                                  child: Text('Введите описание прививки:',
                                                      style: Theme.of(context).copyWith().textTheme.bodyText1),
                                                ),
                                              ),
                                              TextFormField(
                                                maxLines: 3,
                                                validator: (value) =>
                                                    value.isEmpty
                                                        ? "Введите текст"
                                                        : null,
                                                onChanged: (value) {
                                                  type = value;
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:'Введите информацию о прививке',
                                                  hintStyle: TextStyle(
                                                      color: Color.fromARGB(153, 69, 69, 69)),
                                                ),
                                              ),
                                            ],
                                          ),
                                    decoration: BoxDecoration(
                                    boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(43, 0, 0, 0),
                                      blurRadius: 5,
                                      offset: const Offset(0.0, 0.0),
                                      spreadRadius: 2.0,
                                    )
                                  ],  
                                    color: Color.fromARGB(202, 242, 242, 242),
                                    border: Border.all(color:Color.fromARGB(202, 242, 242, 242)),
                                    borderRadius: BorderRadius.circular(10),
                                    ),),

                                        SizedBox(height: 15),

                                        Container(
                                          padding: EdgeInsets.symmetric( horizontal: 7, vertical: 12),
                                          //margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text('Введите дату прививки:',
                                                    style: Theme.of(context).copyWith().textTheme.bodyText1),
                                                ),
                                              ),
                                              TextFormField(
                                                maxLines: 3,
                                                validator: (value) =>
                                                    value.isEmpty
                                                        ? "Введите текст"
                                                        : null,
                                                onChanged: (value) {
                                                  date = value;
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:'Введите дату прививки',
                                                  hintStyle: TextStyle(
                                                      color: Color.fromARGB(153, 69, 69, 69)),
                                                ),
                                              ),
                                            ],
                                          ),
                                    decoration: BoxDecoration(
                                    boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(43, 0, 0, 0),
                                      blurRadius: 5,
                                      offset: const Offset(0.0, 0.0),
                                      spreadRadius: 2.0,
                                    )
                                  ],  
                                    color: Color.fromARGB(202, 242, 242, 242),
                                    border: Border.all(color:Color.fromARGB(202, 242, 242, 242)),
                                    borderRadius: BorderRadius.circular(10),
                                    ),),

                                        SizedBox(height: 15),

                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                                          child: Column(
                                            children: [
                                              Container(
                                                 padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                                                child: Align(
                                                  alignment: Alignment.bottomLeft,
                                                  child: Text('Нужна ли ревакцинация:',
                                                    style: Theme.of(context).copyWith().textTheme.bodyText1),
                                                ),
                                              ),

                                              Container(
                                                child: SelectFormField(
                                                  autofocus: false,
                                                  items: [
                                                    {
                                                      'value': 'Да',
                                                      'label': 'Да'
                                                    },
                                                    {
                                                      'value': 'Нет',
                                                      'label': 'Нет'
                                                    }
                                                  ],
                                                  validator: (value) =>
                                                      value.isEmpty
                                                          ? "Поле пустое"
                                                          : null,
                                                  onChanged: (value) => value ==
                                                          'Да'
                                                      ? revaccination = true
                                                      : revaccination = false,
                                                  onSaved: (value) => value ==
                                                          'Да'
                                                      ? revaccination = true
                                                      : revaccination = false,
                                                  decoration: buildInputDecoration(
                                                      "Нужна ли ревакцинация?",
                                                      Icons.vaccines),
                                                ),
                                              ),
                                            ],
                                          ),
                                    decoration: BoxDecoration(
                                    boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(43, 0, 0, 0),
                                      blurRadius: 5,
                                      offset: const Offset(0.0, 0.0),
                                      spreadRadius: 2.0,
                                    )
                                  ],  
                                    color: Color.fromARGB(202, 242, 242, 242),
                                    border: Border.all(color:Color.fromARGB(202, 242, 242, 242)),
                                    borderRadius: BorderRadius.circular(10),
                                    ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          Future.delayed(
                            Duration.zero,
                            () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('+ Добавить прививку',
                        style: Theme.of(context).copyWith().textTheme.bodyText1),
                    ),
                  ),
                  vacc.length == 0
                      ? ListBody(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ListBody(
                                children: [
                                  Container(
                                      height:
                                          window.physicalSize.height / 2 - 48),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("Отмеченных прививок пока нет",
                                      style: Theme.of(context).copyWith().textTheme.bodyText1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: vacc.length,
                          itemBuilder: (context, index) {
                            return VaccinationsCard(vacc[index]);
                          },
                        ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
