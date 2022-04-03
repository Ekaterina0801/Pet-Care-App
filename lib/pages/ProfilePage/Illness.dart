import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
  final formKey = new GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Прививки",
      body: ListView.builder(
        itemCount: disease.length,
  itemBuilder: (context, index) {
      return DiseaseCard(disease[index], disease_start[index],disease_end[index]);
  }),
    );
  }
}

class DiseaseCard extends StatelessWidget {
  String title;
  String start;
  String end;

  DiseaseCard(String title, String start, String end)
  {
    this.title = title;
    this.start = start;
    this.end = end;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        color: Color.fromRGBO(240, 240, 240, 1),
              shadowColor: Colors.grey,
        child: ListTile(
          title: Text(title, textAlign: TextAlign.left,
                      style: GoogleFonts.comfortaa(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 16)),
          subtitle: Text("Начало: "+ start+"\n"+"Конец: "+ end),
        ),
      )
      
    );
  }
}

class Disease
{
  int diseaseID;
  int petID;
  //int userID;
  String type;
  String dateofbeggining;
  String dateofending;

Disease({this.diseaseID,this.petID,this.type,this.dateofbeggining,this.dateofending});

factory Disease.fromJson(Map<String, Object> json) => Disease(
       diseaseID: json['DiseaseID'],
       type: json['Type'],
       petID: json['PetID'],
       dateofbeggining: json['DateOfBeggining'],
       dateofending: json['DateOfEnding']
       
      );

  Map<String, dynamic> toJson() => {
        'DiseaseID':diseaseID,
        'Type':type,
        'PetID':petID,
        'DateOfBeggining':dateofbeggining,
        'DateOfEnding':dateofending
      };
}

Future<List<Disease>> getDiseases(int userID) async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Pets.json')));
    Disease(
       diseaseID: 0,
       type: "-",
       petID: 0,
       dateofbeggining: "-",
       dateofending: "-"
       
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
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Pets.json')));
    
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