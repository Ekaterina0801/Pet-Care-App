import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'package:select_form_field/select_form_field.dart';

import '../BasePage.dart';
import 'package:http/http.dart' as http;

import '../NotesPage/AppBuilder.dart';
import '../Registration/util/widgets.dart';

List<String> photos = [
  "./assets/images/article_2.6.jpg",
  "./assets/images/article_1.2.jpg",
  "./assets/images/article_1.1.jpg"
];

class VaccinationPage extends StatefulWidget {
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
  List<Vaccination> allvacc = [];
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
                    allvacc = snapshot.data;
              }
              vacc = [];
              for (var n in allvacc) {
                if (n.userID == user.userid) vacc.add(n);
              }
              return ListView(
                shrinkWrap: true,
                children: [
                  FlatButton(
                    height: 50,
                    color: Colors.grey.shade200,
                    onPressed: () {
                      setState(
                        () {
                          final formKey = new GlobalKey<FormState>();
                          AlertDialog alert = AlertDialog(
                            title: Container(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Добавление прививки',
                                  style: GoogleFonts.comfortaa(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            actions: [
                              FlatButton(
                                child: Text(
                                  'Добавить',
                                  style: GoogleFonts.comfortaa(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14),
                                ),
                                color: Color.fromRGBO(255, 223, 142, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                height: 45,
                                onPressed: () {
                                  setState(
                                    () {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                        addVaccination("0", user.userid, "0",
                                            date, type, "", revaccination);
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
                                                      'Введите описание прививки:',
                                                      //textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.comfortaa(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 14)),
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
                                                      'Введите информацию о прививке',
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
                                                      'Введите дату прививки:',
                                                      //textAlign: TextAlign.left,
                                                      style:
                                                          GoogleFonts.comfortaa(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 14)),
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
                                                  hintText:
                                                      'Введите дату прививки',
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
                                                    'Нужна ли ревакцинация:',
                                                    //textAlign: TextAlign.left,
                                                    style:
                                                        GoogleFonts.comfortaa(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 14),
                                                  ),
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
                                                      Icons.home),
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
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '+ Добавить прививку',
                        style: GoogleFonts.comfortaa(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
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
                                    child: Text(
                                      "Отмеченных прививок пока нет",
                                      style: GoogleFonts.comfortaa(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16),
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

Future<Map<String, dynamic>> addVaccination(
    String vaccinationId,
    int userID,
    String petID,
    String date,
    String type,
    String document,
    bool revaccination) async {
  final Map<String, dynamic> dData = {
    'Type': type,
    'VaccinationID': vaccinationId,
    'UserID': userID,
    'PetID': petID,
    'Date': date,
    'Document': "-",
    'Revaccination': revaccination
  };

  var response = await post(
      Uri.parse(
          'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Vaccinations.json'),
      body: json.encode(dData));
  Vaccination vac = Vaccination(
      type: dData['Type'],
      vaccinationId: dData['VaccinationID'],
      petId: dData['PetID'],
      date: dData['Date'],
      document: dData['Document'],
      revaccination: dData['Revaccination'],
      userID: dData['UserID']);
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': vac};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
}

class VaccinationsCard extends StatelessWidget {
  Vaccination vac;
  VaccinationsCard(Vaccination vac) {
    this.vac = vac;
  }
  int vaccinationId;
  int userID;
  int petId;
  String type;
  String date;
  String document;
  bool revactination;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color.fromRGBO(255, 223, 142, 100)),
        child: Column(
          children: [
            Image.asset(photos[0]),
            Container(
              margin: EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  vac.date,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.comfortaa(
                      decoration: TextDecoration.underline,
                      //fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
              ),
            ),
            Container(
              //decoration:
              //    BoxDecoration(color: Color.fromRGBO(255, 223, 142, 100)),
              child: Row(
                children: [
                  Container(
                    //padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(18),
                    child: Text(
                      vac.type,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.comfortaa(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class Vaccination {
  String vaccinationId;
  int userID;
  String petId;
  String type;
  String date;
  String document;
  bool revaccination;

  Vaccination(
      {this.vaccinationId,
      this.userID,
      this.petId,
      this.date,
      this.type,
      this.document,
      this.revaccination});
  factory Vaccination.fromJson(Map<String, Object> json) => Vaccination(
      userID: json['UserID'],
      vaccinationId: json['VaccinationID'],
      petId: json['PetID'],
      date: json['Date'],
      type: json['Type'],
      document: json['Document'],
      revaccination: json['Revaccination']);

  Map<String, dynamic> toJson() => {
        'UserID': userID,
        'VaccinationID': vaccinationId,
        'PetID': petId,
        'Date': date,
        'Type': type,
        'Document': document,
        'Revactination': revaccination
      };
}

Future<List<Vaccination>> getVaccinnations(int userID) async {
  Response res = await http.get(Uri.parse(Uri.encodeFull(
      'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Vaccinations.json')));
  Vaccination(
    userID: userID,
    vaccinationId: "-",
    petId: "-",
    date: "-",
    type: "-",
    document: "-",
    revaccination: false,
  );
  List<Vaccination> vacc = [];
  if (res.statusCode == 200) {
    var ll = jsonDecode(res.body);
    for (var t in ll.keys) {
      vacc.add(ll[t]);
    }
  } else {
    throw "Unable to retrieve vaccinations.";
  }
  return vacc;
}

class VaccinationController extends ControllerMVC {
  // создаем наш репозиторий
  final RepositoryVaccinations repo = new RepositoryVaccinations();

  // конструктор нашего контроллера
  VaccinationController();

  // первоначальное состояние - загрузка данных
  VaccinationResult currentState = VaccinationResultLoading();

  void init() async {
    try {
      // получаем данные из репозитория
      final vaccList = await repo.getvacc();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = VaccinationResultSuccess(vaccList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = VaccinationResultFailure("Нет интернета"));
    }
  }
}

class RepositoryVaccinations {
  Future<List<Vaccination>> getvacc() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull(
        'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Vaccinations.json')));

    if (res.statusCode == 200) {
      //var rb = res.body;
      List<Vaccination> list = [];
      var ll = jsonDecode(res.body);
      for (var t in ll.keys) {
        Vaccination a = Vaccination.fromJson(ll[t]);
        //if(a.userID==)
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve pets.";
    }
  }
}

abstract class VaccinationResult {}

//указатель на успешный запрос
class VaccinationResultSuccess extends VaccinationResult {
  final List<Vaccination> vaccList;
  VaccinationResultSuccess(this.vaccList);
}

// произошла ошибка
class VaccinationResultFailure extends VaccinationResult {
  final String error;
  VaccinationResultFailure(this.error);
}

// загрузка данных
class VaccinationResultLoading extends VaccinationResult {
  VaccinationResultLoading();
}
