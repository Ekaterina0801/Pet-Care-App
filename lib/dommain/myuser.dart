import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care/pages/CalendarPage/Meeting.dart';
import 'package:pet_care/pages/ProfilePage/Disease.dart';
import 'package:pet_care/pages/ProfilePage/Vaccination.dart';

import '../pages/NotesPage/Note.dart';
import '../pages/ProfilePage/Pet.dart';
class MyUser {
  int userid;
  String firstname;
  String lastname;
  String email;
  String password;
  String district;
  bool readyforoverposure;
  List<Meeting> mentions;
  List<Note> notes;
  List<Pet> pets;
  //String price;
  //String typePets;
  //String stringID;
  //Pet pet;

  MyUser({this.userid,this.email,this.password,this.firstname,this.lastname,this.district,this.readyforoverposure,this.mentions,this.notes,this.pets});

  factory MyUser.fromJson(Map<String, dynamic> responseData) {
    return MyUser(
        userid: responseData['userId'],
        firstname: responseData['firstName'],
        lastname: responseData['lastName'],
        email: responseData['email'],
        password: responseData['password'],
        district: responseData['district'],
        readyforoverposure: responseData['readyForOvereposure'], 
        mentions: responseData['mentions'].cast<Meeting>(),
        notes: responseData['notes'].cast<Note>(),
        pets:responseData['pets'].cast<Pet>(),
       // illnesses: responseData['illnesses'],
       // vaccinations: responseData['vaccinations']
        //stringID:responseData['StringID'],
        //pet: responseData['Pet'],
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userid,
        'firstName': firstname,
        'lastName': lastname,
        'password':password,
        'email':email,
        'district':district,
        'readyForOvereposure':readyforoverposure,
        'mentions':mentions,
        'notes':notes,
        'pets':pets,
        //'illnesses':illnesses,
        //'vaccinations':vaccinations
        //'StringID':stringID
        //'Pet':pet
      };

  Map toMap() => {"userID":userid, "firstName":firstname, "lastName":lastname,"password": password,"email":email,"district":district, 'readyForOvereposure':readyforoverposure, 'mentions':mentions, 'notes':notes, 'pets':pets};
}

class MyUserController extends ControllerMVC {
  // создаем наш репозиторий
  final RepositoryUsers repo = new RepositoryUsers();

  // конструктор нашего контроллера
 MyUserController();
  
  // первоначальное состояние - загрузка данных
  MyUserResult currentState = MyUserResultLoading();

  void init() async {
    try {
      // получаем данные из репозитория
      final usersList = await repo.getuser();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = MyUserResultSuccess(usersList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = MyUserResultFailure("Нет интернета"));
    }
  }

}

class RepositoryUsers{
  /*
  Future<List<MyUser>> getusers() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Users.json')));
    if (res.statusCode == 200) {
      //var rb = res.body;
      List<MyUser> list=[];
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
        MyUser a = MyUser.fromJson(ll[t]);
        //if(a.userID==)
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve pets.";
    }
  }*/
  Future<MyUser> getuser() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Users.json')));
    if (res.statusCode == 200) {
      //var rb = res.body;
      
      var ll = jsonDecode(res.body);
      
        MyUser a = MyUser.fromJson(ll);
        //if(a.userID==)
       
      
      return a;
    } else {
      throw "Unable to retrieve users.";
    }
  }
  }

  abstract class MyUserResult{}

//указатель на успешный запрос
class MyUserResultSuccess extends MyUserResult {
  final MyUser usersList;
  MyUserResultSuccess(this.usersList);
}

// произошла ошибка
class MyUserResultFailure extends MyUserResult {
  final String error;
  MyUserResultFailure(this.error);
}

// загрузка данных
class MyUserResultLoading extends MyUserResult {
 MyUserResultLoading();
}
