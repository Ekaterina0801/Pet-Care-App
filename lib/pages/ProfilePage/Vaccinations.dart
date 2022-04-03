import 'dart:convert';

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

class VaccinationsPage extends StatefulWidget {
  @override
  _VaccinationsPageState createState() => _VaccinationsPageState();
}

class _VaccinationsPageState extends StateMVC {
  VaccinationController _controller;
  _VaccinationsPageState():super(VaccinationController()){_controller = controller as VaccinationController;}
  @override
  void initState() {
    super.initState();
    _controller.init();
  }
  final formKey = new GlobalKey<FormState>();
  MyUser user;
  @override
  Widget build(BuildContext context) {
    Future<MyUser> getUserData() => UserPreferences().getUser();
    final state = _controller.currentState;
if (state is VaccinationResultLoading) {
      // загрузка
      return 
         Center(
          child: CircularProgressIndicator(),
       
      );
    } else if (state is VaccinationResultFailure) {
      // ошибка
      return Center(
        child: Text(
          state.error,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.red)
        ),
      );
    } else {  
      final l = (state as VaccinationResultSuccess).vaccList; 
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
      child: FutureBuilder(
       
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
        List<Vaccination> vacc =[];
        //vacc = user.pet.
        for(var i in l)
        {
          if(i.userID==user.userid)
          vacc.add(i);
        }
          return BasePage(
            title: "Прививки",
            body: ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return Padding(
                  child: VaccinationsCard(user.pet.vaccinations[index]),
                  padding: EdgeInsets.symmetric(vertical: 20),
                );
              },
              padding: EdgeInsets.all(10),
            ),
          );
        }
      ),
    );
  }
}
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
            Image.asset(vac.document),
            Container(
              margin: EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(vac.date,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.comfortaa(
                        decoration: TextDecoration.underline,
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 15)),
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
                    child: Text(vac.type,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.comfortaa(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class Vaccination
{
  int vaccinationId;
  int userID;
  int petId;
  String type;
  String date;
  String document;
  bool revactination;

Vaccination({this.vaccinationId,this.userID,this.petId,this.date,this.type,this.document,this.revactination});
factory Vaccination.fromJson(Map<String, Object> json) => Vaccination(
       userID: json['UserID'],
       vaccinationId: json['VaccinationID'],
       petId: json['PetID'],
       date: json['Date'],
       type: json['Type'],
       document: json['Document'],
       revactination: json['Revactination']
      );

  Map<String, dynamic> toJson() => {
        'UserID':userID,
        'VaccinationID':vaccinationId,
        'PetID':petId,
        'Date':date,
        'Type':type,
        'Document':document,
        'Revactination':revactination
      };
}

Future<List<Vaccination>> getVaccinnations(int userID) async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Users/Pets/Vaccinations.json')));
    Vaccination(
       userID: userID,
       vaccinationId: 0,
       petId: 0,
       date: "-",
       type: "-",
       document: "-",
       revactination: false,
      );
    List<Vaccination> vacc=[];
    if (res.statusCode == 200) {
      
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
        vacc.add(ll[t]);
      }
    } else {
      throw "Unable to retrieve vaccinations.";
    }return vacc;
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

class RepositoryVaccinations{
  Future<List<Vaccination>> getvacc() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Users/Pets/Vaccinations.json')));
    
    if (res.statusCode == 200) {
      //var rb = res.body;
      List<Vaccination> list=[];
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
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

  abstract class VaccinationResult{}

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