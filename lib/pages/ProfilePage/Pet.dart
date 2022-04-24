import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// импортируем http пакет
import 'package:http/http.dart' as http;

import 'Vaccinations.dart';

class Pet
{
  int petID;
  int userID;
  String animal;
  String name;
  String breed;
  String dateofbirthday;
  String gender;
  String weight;
  String color;
  String petidString;
  //List<Vaccination> vaccinations;
  //List<Disease> diseases;
  Pet({this.petID,this.userID,this.animal,this.name,this.breed,this.dateofbirthday,this.gender,this.weight,this.color,this.petidString});

factory Pet.fromJson(Map<String, Object> json) => Pet(
       petID: json['PetID'],
       userID: json['UserID'],
       animal: json['Animal'],
       name: json['Name'],
       breed: json['Breed'],
       dateofbirthday: json['DateOfBirthday'],
       gender:json['Gender'],
       weight: json['Weight'],
       color: json['Color'],
       petidString:json['PetIDString']
      );

  Map<String, dynamic> toJson() => {
        'PetID':petID,
        'UserID':userID,
        'Animal':animal,
        'Name':name,
        'Breed':breed,
        'DateOfBirthday':dateofbirthday,
        'Gender':gender,
        'Weight':weight,
        'Color':color,
        'PetIDString':"-"
      };
}

Future<Pet> getPet(int userID) async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Pets.json')));
    List<Vaccination> v=[];
    v.add(Vaccination(
          date: "-",
          vaccinationId: 0,
          userID: userID,
          petId: 0,
          type: "-",
          document: "-",
          revactination: false
        ));
    Pet pet = Pet(
        petID: 1,
        userID: userID,
        animal:"-",
        name:"-",
        breed:"-",
        dateofbirthday: "-",
        gender: "-",
        weight: "0",
        color:"-"
      );
    if (res.statusCode == 200) {
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
        if(ll[t].userID==userID)
        {
          pet = Pet.fromJson(ll[t]);
          break;
        }
      }
      
    } else {
      throw "Unable to retrieve pets.";
    }return pet;
  }

  Future<List<Pet>> getPets() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Pets.json')));
    List<Pet> pets = [];
    if (res.statusCode == 200) {

      var ll = jsonDecode(res.body);
      
      for(var t in ll.keys)
      {
        var a = Pet.fromJson(ll[t]);
        a.petidString=t;
        //ll[t].petidString=t;
        pets.add(a); 
      }
      
    } else {
      throw "Unable to retrieve pets.";
    }return pets;
  }

  class PetController extends ControllerMVC {
  // создаем наш репозиторий
  final RepositoryPets repo = new RepositoryPets();

  // конструктор нашего контроллера
 PetController();
  
  // первоначальное состояние - загрузка данных
  PetResult currentState = PetResultLoading();

  void init() async {
    try {
      // получаем данные из репозитория
      final petsList = await repo.getpets();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = PetResultSuccess(petsList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = PetResultFailure("Нет интернета"));
    }
  }

}

class RepositoryPets{
  Future<List<Pet>> getpets() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Pets.json')));
    
    if (res.statusCode == 200) {
      //var rb = res.body;
      List<Pet> list=[];
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
        Pet a = Pet.fromJson(ll[t]);
        a.petidString=t;
        //if(a.userID==)
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve pets.";
    }
  }
  }

  abstract class PetResult{}

//указатель на успешный запрос
class PetResultSuccess extends PetResult {
  final List<Pet> petsList;
  PetResultSuccess(this.petsList);
}

// произошла ошибка
class PetResultFailure extends PetResult {
  final String error;
  PetResultFailure(this.error);
}

// загрузка данных
class PetResultLoading extends PetResult {
 PetResultLoading();
}