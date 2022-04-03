import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'package:pet_care/pages/providers/auth.dart';
import 'package:pet_care/pages/providers/userprovider.dart';
import 'package:provider/provider.dart';

import '../BasePage.dart';
import 'package:http/http.dart' as http;
List<String> photos = [
  "./assets/images/article_2.6.jpg",
  "./assets/images/article_1.2.jpg",
  "./assets/images/article_1.1.jpg"
];
List<String> date = ["01.02.2021", "01.04.2021", "12.05.2021"];
List<String> titles = [
  "Прививка от бешенства",
  "Другая важная прививка",
  "Третья важная прививка"
];

class DiseasesPage extends StatefulWidget {
  @override
  _DiseasesPageState createState() => _DiseasesPageState();
}

class _DiseasesPageState extends StateMVC {
  DiseaseController _controller;
  _DiseasesPageState():super(DiseaseController()){_controller = controller as DiseaseController;}
  @override
  void initState() {
    super.initState();
    _controller.init();
  }
  MyUser user;
  final formKey = new GlobalKey<FormState>();
  String type; String datebeg; String dateend;
  @override
  Widget build(BuildContext context) {
    Future<MyUser> getUserData() => UserPreferences().getUser();
    final state = _controller.currentState;
  
if (state is DiseaseResultLoading) {
      // загрузка
      return 
         Center(
          child: CircularProgressIndicator(),
       
      );
    } else if (state is DiseaseResultFailure) {
      // ошибка
      return Center(
        child: Text(
          state.error,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.red)
        ),
      );
    } else {  
      final l = (state as DiseaseResultSuccess).diseasesList; 
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
                      else user=snapshot.data;

                        //UserPreferences().removeUser();
                      
                  }
        List<Disease> diseases =[];
        //vacc = user.pet.
        for(var i in l)
        {
          if(i.userID==user.userid)
          diseases.add(i);
        }
          return BasePage(
            title: "Болезни",
            body: ListView(
              shrinkWrap: true,
                children:[FlatButton(
                        height: 50,
                        color: Colors.grey.shade200,
                        onPressed: () {
                          setState(() {
                            //_displayNoteAdd(context, _body, _date);
                            final formKey = new GlobalKey<FormState>();
                            AlertDialog alert = AlertDialog(
                              title: Text('Добавление болезни'),
                              actions: [
                                FlatButton(
                                    child: Text(
                                      'Добавить',
                                      style: GoogleFonts.comfortaa(
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        addDisease(type, datebeg,dateend, user.userid);
                                        //notifyListeners();

                                        //AppBuilder.of(context).rebuild();
                                        Navigator.popAndPushNamed(context,'/home');
                                      });
                                      Navigator.of(context).pop();
                                      //Navigator.pushNamed(context, "/notes");
                                    }),
                              ],
                              content: //_displayDiseaseAdd(context, type, datebeg, dateend, user.userid)
                              
                              Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text("Введите описание болезни"),
                      TextField(
                        maxLines: 10,
                        
                        onChanged: (value) {
                          type = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Введите информацию о болезни',
                          hintStyle: TextStyle(color: Colors.white60),
                        ),
                      ),
                      Text("Введите дату начала болезни"),
                      TextField(
                    maxLines: 2,
                    onChanged: (value) {
                      datebeg = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Введите дату начала болезни',
                      hintStyle: TextStyle(color: Colors.white60),
                    ),
                  ),
                  Text("Введите дату окончания болезни"),
                  TextField(
                    maxLines: 2,
                    onChanged: (value) {
                      dateend = value;
                      
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Введите дату окончания болезни',
                      hintStyle: TextStyle(color: Colors.white60),
                    ),
                  )
                    ],
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
                          });
                        },
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text('+ Добавить болезнь',
                                style: GoogleFonts.comfortaa(
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16)))),
                  diseases.length==0?ListBody(
                          children: [
                        // Container(
                          //height: window.physicalSize.height / 2 - 32),
                           Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Отмеченных болезней пока нет",
                              style: GoogleFonts.comfortaa(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          )
                          ]):ListView.builder(
                            shrinkWrap: true,
                             physics: ScrollPhysics(),
                itemCount: diseases.length,
        itemBuilder: (context, index) {
              return DiseaseCard(diseases[index]);
        }),
                ]),
          );
        }
      ),
    );
  }}
}

class DiseaseCard extends StatelessWidget {
  Disease disease;

  DiseaseCard(Disease disease)
  {
    this.disease=disease;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        color: Color.fromRGBO(240, 240, 240, 1),
              shadowColor: Colors.grey,
        child: ListTile(
          title: Text(disease.type, textAlign: TextAlign.left,
                      style: GoogleFonts.comfortaa(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 16)),
          subtitle: Text("Начало: "+ disease.dateofbeggining+"\n"+"Конец: "+ disease.dateofending),
        ),
      )
      
    );
  }
}

class Disease
{
  int diseaseID;
  int petID;
  int userID;
  String type;
  String dateofbeggining;
  String dateofending;

Disease({this.diseaseID,this.userID,this.petID,this.type,this.dateofbeggining,this.dateofending});

factory Disease.fromJson(Map<String, Object> json) => Disease(
       diseaseID: json['DiseaseID'],
       type: json['Type'],
       petID: json['PetID'],
       dateofbeggining: json['DateOfBeggining'],
       dateofending: json['DateOfEnding'],
       userID: json['UserID'],
      );

  Map<String, dynamic> toJson() => {
        'DiseaseID':diseaseID,
        'Type':type,
        'PetID':petID,
        'DateOfBeggining':dateofbeggining,
        'DateOfEnding':dateofending,
        'UserID':userID
      };
}

Future<List<Disease>> getDiseases(int userID) async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Diseases.json')));
    Disease(
       diseaseID: 0,
       type: "-",
       petID: 0,
       dateofbeggining: "-",
       dateofending: "-",
       userID: userID
      );
    List<Disease> vacc=[];
    if (res.statusCode == 200) {
      
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
        vacc.add(ll[t]);
      }
    } else {
      throw "Unable to retrieve diseases.";
    }return vacc;
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

class RepositoryDiseases{
  Future<List<Disease>> getdiseases() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Diseases.json')));
    
    if (res.statusCode == 200) {
      //var rb = res.body;
      List<Disease> list=[];
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
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

  abstract class DiseaseResult{}

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

_displayDiseaseAdd(
      BuildContext context, String type, String datebeg, String dateend, int userID) {
    final formKey = new GlobalKey<FormState>();
    AlertDialog alert = AlertDialog(
      title: Text('Добавление информации'),
      actions: [
        FlatButton(
          child: Text(
            'Добавить',
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 14),
          ),
          onPressed: () {
            addDisease(type,datebeg,dateend, userID);
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
      String type, String datebeg,String dateend, int userID) async {
//Future<MyUser> getUserData() => UserPreferences().getUser();

    final Map<String, dynamic> dData = {
      'Type': type,
      'DateOfBeggining': datebeg,
      'DateOfEnding':dateend,
      'DiseaseID': 1,
      'PetID':1,
      'UserID': userID
    };

    var response = await post(
        Uri.parse(
            'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Diseases.json'),
        body: json.encode(dData));
    Disease note = Disease(
        type: dData['Type'], diseaseID: dData['DiseaseID'], petID:dData['PetID'],dateofbeggining: dData['DateOfBeggining'],dateofending: dData['DateOfEnding']);
    var result;
    if (response.request != null)
      result = {'status': true, 'message': 'Successfully add', 'data': note};
    else {
      result = {'status': false, 'message': 'Adding failed', 'data': null};
    }
    return result;
  }
  
