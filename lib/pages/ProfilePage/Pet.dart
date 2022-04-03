import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
// импортируем http пакет
import 'package:http/http.dart' as http;

class Pet
{
  int petID;
  int userID;
  String animal;
  String name;
  String breed;
  String dateofbirthday;
  String gender;
  double weight;
  String color;
  Pet({this.petID,this.userID,this.animal,this.name,this.breed,this.dateofbirthday,this.gender,this.weight,this.color});

factory Pet.fromJson(Map<String, Object> json) => Pet(
       petID: json['PetID'],
       userID: json['UserID'],
       animal: json['Animal'],
       name: json['Name'],
       breed: json['Breed'],
       dateofbirthday: json['DateOfBirthday'],
       gender:json['Gender'],
       weight: json['Weight'],
       color: json['Color']
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
        'Color':color
      };
}

Future<Pet> getPet(int userID) async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Pets.json')));
    Pet pet = Pet(
        petID: 1,
        userID: userID,
        animal:"-",
        name:"-",
        breed:"-",
        dateofbirthday: "-",
        gender: "-",
        weight: 0.0,
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
    Pet pet = Pet(
        petID: 1,
        userID: -1,
        animal:"-",
        name:"-",
        breed:"-",
        dateofbirthday: "-",
        gender: "-",
        weight: 0.0,
        color:"-"
      );
    List<Pet> pets = [];
    if (res.statusCode == 200) {

      var ll = jsonDecode(res.body);
      
      for(var t in ll.keys)
      {
        pets.add(ll[t]); 
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