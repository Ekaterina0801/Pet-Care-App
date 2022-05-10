import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/ProfilePage/Pet.dart';
import 'package:http/http.dart' as http;
class MyUser {
  int userid;
  String firstname;
  String lastname;
  String email;
  String password;
  String district;
  String readyforoverposure;
  String price;
  String typePets;
  //String stringID;
  //Pet pet;

  MyUser({this.userid,this.email,this.password,this.firstname,this.lastname,this.district,this.readyforoverposure,this.price,this.typePets});

  factory MyUser.fromJson(Map<String, dynamic> responseData) {
    return MyUser(
        userid: responseData['UserID'],
        firstname: responseData['FirstName'],
        lastname: responseData['LastName'],
        email: responseData['Email'],
        password: responseData['Password'],
        district: responseData['District'],
        readyforoverposure: responseData['ReadyForOverposure'], 
        typePets: responseData['TypeOfPets'],
        price: responseData['Price'],
        //stringID:responseData['StringID'],
        //pet: responseData['Pet'],
    );
  }

  Map<String, dynamic> toJson() => {
        'UserID': userid,
        'FirstName': firstname,
        'LastName': lastname,
        'Password':password,
        'Email':email,
        'District':district,
        'ReadyForOverposure':readyforoverposure,
        'TypeOfPets':typePets,
        'Price':price,
        //'StringID':stringID
        //'Pet':pet
      };

  Map toMap() => {"UserID":userid, "FirstName":firstname, "LastName":lastname,"Password": password,"Email":email,"District":district};
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
      final usersList = await repo.getusers();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = MyUserResultSuccess(usersList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = MyUserResultFailure("Нет интернета"));
    }
  }

}

class RepositoryUsers{
  Future<List<MyUser>> getusers() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Users.json')));
    var rb = res.body;
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
  }
  }

  abstract class MyUserResult{}

//указатель на успешный запрос
class MyUserResultSuccess extends MyUserResult {
  final List<MyUser> usersList;
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
