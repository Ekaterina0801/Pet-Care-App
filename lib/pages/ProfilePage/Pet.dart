import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
// импортируем http пакет
import 'package:http/http.dart' as http;

import 'Disease.dart';
import 'Vaccination.dart';


class Pet
{
  int petId;
  int userId;
  String animal;
  String name;
  String breed;
  String dateofbirthday;
  String gender;
  String weight;
  String color;
  String photo;
  List<Disease> illnesses;
  List<Vaccination> vaccinations;
  //List<Vaccination> vaccinations;
  //List<Disease> diseases;
  Pet({this.petId,this.userId,this.animal,this.name,this.breed,this.dateofbirthday,this.gender,this.weight,this.color,this.photo, this.illnesses,this.vaccinations});

factory Pet.fromJson(Map<String, Object> json) => Pet(
       petId: json['petId'],
       userId: json['userId'],
       animal: json['animal'],
       name: json['name'],
       breed: json['breed'],
       dateofbirthday: json['dateOfBirth'],
       gender:json['gender'],
       weight: json['weight'],
       color: json['color'],
       photo: json['photo'],
       illnesses: json['illnesses'],
       vaccinations: json['vaccinations']
      );

  Map<String, dynamic> toJson() => {
        'petId':petId,
        'dserID':userId,
        'animal':animal,
        'name':name,
        'breed':breed,
        'dateOfBirth':dateofbirthday,
        'gender':gender,
        'weight':weight,
        'color':color,
        'photo':"-",
        'illnesses':illnesses,
        'vaccinations':vaccinations
      };
}

Future<Pet> getPet(int userID) async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Pets.json')));
    
    Pet pet = Pet(
        petId: 1,
        userId: userID,
        animal:"-",
        name:"-",
        breed:"-",
        dateofbirthday: "-",
        gender: "-",
        weight: "0",
        color:"-",
        photo: "-",
        illnesses: [],
        vaccinations: []
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
        //a.petidString=t;
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
        //a.petidString=t;
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