import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import '../BasePage.dart';
import 'package:http/http.dart' as http;

import '../NotesPage/AppBuilder.dart';

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
  List<Disease> diseases = [];
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
              diseases = [];
              for (var n in alldisease) {
                if (n.userID == user.userid) diseases.add(n);
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
                          _displayDiseaseAdd(context, type, datebeg, dateend, user.userid);
                          AlertDialog alert = AlertDialog(
                            title: Container(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text('Добавление болезни',
                                    style: Theme.of(context).copyWith().textTheme.bodyText1),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  child: Text(
                                    'Добавить',
                                    style: Theme.of(context).copyWith().textTheme.bodyText1,
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
                                      }
                                      this.setState(() {});
                                    });
                                    Navigator.of(context).pop(true);

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
                                                      style:
                                                          Theme.of(context).copyWith().textTheme.bodyText1),
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
                                                      style:
                                                          Theme.of(context).copyWith().textTheme.bodyText1),
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
                                                      style:
                                                          Theme.of(context).copyWith().textTheme.bodyText1),
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
                        '+ Добавить болезнь',
                        style: Theme.of(context).copyWith().textTheme.bodyText1,
                      ),
                    ),
                  ),
                  diseases.length == 0
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
                                      style: Theme.of(context).copyWith().textTheme.bodyText1,
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
                          itemCount: diseases.length,
                          itemBuilder: (context, index) {
                            return DiseaseCard(diseases[index]);
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

class DiseaseCard extends StatelessWidget {
  Disease disease;

  DiseaseCard(Disease disease) {
    this.disease = disease;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Card(
          color: Color.fromRGBO(240, 240, 240, 1),
          shadowColor: Colors.grey,
          child: ListTile(
            title: Text(disease.type,
                textAlign: TextAlign.left,
                style: Theme.of(context).copyWith().textTheme.bodyText1),
            subtitle: Text("Начало: " +
                disease.dateofbeggining +
                "\n" +
                "Конец: " +
                disease.dateofending, style: Theme.of(context).copyWith().textTheme.bodyText1),
          ),
        ));
  }
}

class Disease {
  int diseaseID;
  int petID;
  int userID;
  String type;
  String dateofbeggining;
  String dateofending;

  Disease(
      {this.diseaseID,
      this.userID,
      this.petID,
      this.type,
      this.dateofbeggining,
      this.dateofending});

  factory Disease.fromJson(Map<String, Object> json) => Disease(
        diseaseID: json['DiseaseID'],
        type: json['Type'],
        petID: json['PetID'],
        dateofbeggining: json['DateOfBeggining'],
        dateofending: json['DateOfEnding'],
        userID: json['UserID'],
      );

  Map<String, dynamic> toJson() => {
        'DiseaseID': diseaseID,
        'Type': type,
        'PetID': petID,
        'DateOfBeggining': dateofbeggining,
        'DateOfEnding': dateofending,
        'UserID': userID
      };
}

Future<List<Disease>> getDiseases(int userID) async {
  Response res = await http.get(Uri.parse(Uri.encodeFull(
      'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Diseases.json')));
  Disease(
      diseaseID: 0,
      type: "-",
      petID: 0,
      dateofbeggining: "-",
      dateofending: "-",
      userID: userID);
  List<Disease> vacc = [];
  if (res.statusCode == 200) {
    var ll = jsonDecode(res.body);
    for (var t in ll.keys) {
      vacc.add(ll[t]);
    }
  } else {
    throw "Unable to retrieve diseases.";
  }
  return vacc;
}

class DiseaseController extends ControllerMVC {
  // создаем наш репозиторий
  final RepositoryDiseases repo = new RepositoryDiseases();

  // конструктор нашего контроллера
  DiseaseController();

  // первоначальное состояние - загрузка данных
  DiseaseResult currentState = DiseaseResultLoading();

  void init() async {
    try {
      // получаем данные из репозитория
      final diseasesList = await repo.getdiseases();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = DiseaseResultSuccess(diseasesList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = DiseaseResultFailure("Нет интернета"));
    }
  }
}

class RepositoryDiseases {
  Future<List<Disease>> getdiseases() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull(
        'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Diseases.json')));

    if (res.statusCode == 200) {
      //var rb = res.body;
      List<Disease> list = [];
      var ll = jsonDecode(res.body);
      for (var t in ll.keys) {
        Disease a = Disease.fromJson(ll[t]);
        //if(a.userID==)
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve pets.";
    }
  }
}

abstract class DiseaseResult {}

//указатель на успешный запрос
class DiseaseResultSuccess extends DiseaseResult {
  final List<Disease> diseasesList;
  DiseaseResultSuccess(this.diseasesList);
}

// произошла ошибка
class DiseaseResultFailure extends DiseaseResult {
  final String error;
  DiseaseResultFailure(this.error);
}

// загрузка данных
class DiseaseResultLoading extends DiseaseResult {
  DiseaseResultLoading();
}

_displayDiseaseAdd(BuildContext context, String type, String datebeg,
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
  final Map<String, dynamic> dData = {
    'Type': type,
    'DateOfBeggining': datebeg,
    'DateOfEnding': dateend,
    'DiseaseID': 1,
    'PetID': 1,
    'UserID': userID
  };

  var response = await post(
      Uri.parse(
          'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Diseases.json'),
      body: json.encode(dData));
  Disease note = Disease(
      type: dData['Type'],
      diseaseID: dData['DiseaseID'],
      petID: dData['PetID'],
      dateofbeggining: dData['DateOfBeggining'],
      dateofending: dData['DateOfEnding']);
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': note};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
}
