import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../dommain/myuser.dart';
import '../BasePage.dart';
import '../NotesPage/AppBuilder.dart';
import '../Registration/util/shared_preference.dart';
import 'Disease.dart';
import 'DiseaseCard.dart';
import 'DiseaseController.dart';
import 'Pet.dart';
import 'diseaserepo.dart';

class DiseasePage extends StatefulWidget {
  @override
  _DiseasePageState createState() => _DiseasePageState();
}

class _DiseasePageState extends StateMVC {
  DiseaseController _controller;
  _DiseasePageState() : super(DiseaseController()) {
    _controller = controller as DiseaseController;
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

  final formKey = new GlobalKey<FormState>();
  String type;
  String datebeg;
  String dateend;
  MyUser user;
  List<Disease> alldisease = [];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Болезни',
      body: AppBuilder(
        builder: (context) {
          return FutureBuilder(
            future: RepositoryDiseases().getdiseases(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    alldisease = snapshot.data;
              }

              return ListView(
                shrinkWrap: true,
                children: [
                  ElevatedButton(
                    //height: 50,
                    //color: Colors.grey.shade200,
                    onPressed: () {
                      setState(
                        () {
                          final formKey = new GlobalKey<FormState>();
                          //_displayDiseaseAdd(
                          //   context, type, datebeg, dateend, user.userid);
                          AlertDialog alert = AlertDialog(
                            title: Container(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text('Добавление болезни',
                                    style: Theme.of(context)
                                        .copyWith()
                                        .textTheme
                                        .bodyText1),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  child: Text(
                                    'Добавить',
                                    style: Theme.of(context)
                                        .copyWith()
                                        .textTheme
                                        .bodyText1,
                                  ),
                                  //color: Color.fromRGBO(255, 223, 142, 1),
                                  //shape: RoundedRectangleBorder(
                                  // borderRadius: BorderRadius.all(
                                  //    Radius.circular(10))),
                                  //height: 45,
                                  onPressed: () {
                                    setState(() {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                        addDisease(type, datebeg, dateend,
                                            user.userid);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage(4),
                                          ),
                                        );
                                      }
                                      this.setState(() {});
                                    });

                                    //Navigator.of(context).pop(true);

                                    //Navigator.pushNamed(context, "/notes");
                                  }),
                            ],
                            content: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 10),
                              child: Column(
                                children: [
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 12),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                      'Введите описание болезни:',
                                                      //textAlign: TextAlign.left,
                                                      style: Theme.of(context)
                                                          .copyWith()
                                                          .textTheme
                                                          .bodyText1),
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
                                                  hintText:
                                                      'Введите информацию о болезни',
                                                  hintStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          153, 69, 69, 69)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          color: Color.fromARGB(
                                              153, 229, 229, 229),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 12),
                                          //margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                      'Введите дату начала болезни:',
                                                      //textAlign: TextAlign.left,
                                                      style: Theme.of(context)
                                                          .copyWith()
                                                          .textTheme
                                                          .bodyText1),
                                                ),
                                              ),
                                              TextFormField(
                                                maxLines: 3,
                                                validator: (value) =>
                                                    value.isEmpty
                                                        ? "Введите текст"
                                                        : null,
                                                onChanged: (value) {
                                                  datebeg = value;
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      'Введите дату начала болезни',
                                                  hintStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          153, 69, 69, 69)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 12),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Text(
                                                      'Введите дату окончания болезни:',
                                                      //textAlign: TextAlign.left,
                                                      style: Theme.of(context)
                                                          .copyWith()
                                                          .textTheme
                                                          .bodyText1),
                                                ),
                                              ),
                                              TextFormField(
                                                validator: (value) =>
                                                    value.isEmpty
                                                        ? "Введите текст"
                                                        : null,
                                                maxLines: 3,
                                                onChanged: (value) {
                                                  dateend = value;
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      'Введите дату окончания болезни',
                                                  hintStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          153, 69, 69, 69)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          color: Color.fromARGB(
                                              153, 229, 229, 229),
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
                                  });
                            },
                          );
                        },
                      );
                    },
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '+ Добавить болезнь',
                        style: Theme.of(context).copyWith().textTheme.bodyText1,
                      ),
                    ),
                  ),
                  alldisease.length == 0
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
                                    child: Text(
                                      "Отмеченных болезней пока нет",
                                      style: Theme.of(context)
                                          .copyWith()
                                          .textTheme
                                          .bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: alldisease.length,
                          itemBuilder: (context, index) {
                            return DiseaseCard(alldisease[index]);
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

Widget _displayDiseaseAdd(BuildContext context, String type, String datebeg,
    String dateend, int userID) {
  final formKey = new GlobalKey<FormState>();
  AlertDialog alert = AlertDialog(
    title: Text('Добавление информации'),
    actions: [
      ElevatedButton(
        child: Text(
          'Добавить',
          style: Theme.of(context).copyWith().textTheme.bodyText1,
        ),
        onPressed: () {
          addDisease(type, datebeg, dateend, userID);
          //notifyListeners();
          Navigator.of(context).pop();
        },
      ),
    ],
    content: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                key: formKey,
                child: TextField(
                  maxLines: 10,
                  onChanged: (value) {
                    type = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Введите информацию о болезни',
                    hintStyle: TextStyle(color: Colors.white60),
                  ),
                )),
            Form(
                key: formKey,
                child: TextField(
                  maxLines: 2,
                  onChanged: (value) {
                    datebeg = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Введите дату начала болезни',
                    hintStyle: TextStyle(color: Colors.white60),
                  ),
                )),
            Form(
                key: formKey,
                child: TextField(
                  maxLines: 2,
                  onChanged: (value) {
                    type = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Введите дату окончания болезни',
                    hintStyle: TextStyle(color: Colors.white60),
                  ),
                )),
          ],
        )),
  );

  Future.delayed(Duration.zero, () async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  });
}

Future<Map<String, dynamic>> addDisease(
    String type, String datebeg, String dateend, int userID) async {
  List<Pet> pets = await getPets();
  int petId = pets[0].petId;
  final Map<String, dynamic> dData = {
    'type': type,
    'date_of_begining': datebeg,
    'date_of_ending': dateend,
    'pet_id': petId,
  };

  var response = await post(
    Uri.parse(
        'http://vadimivanov-001-site1.itempurl.com/Register/RegisterIllness'),
    body: json.encode(dData),
    headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
  );
  Disease note = Disease(
      type: dData['type'],
      dateofbeggining: dData['date_of_begining'],
      dateofending: dData['date_of_ending']);
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': note};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
}
