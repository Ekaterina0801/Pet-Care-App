import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/ProfilePage/Pet.dart';
import 'package:pet_care/pages/ProfilePage/Vaccinations.dart';
import 'package:pet_care/pages/Registration/util/appurl.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';

MyUser myuser;


enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {

  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<List<MyUser>> allUsers()async {
    //var result;
    //var jsonString = '[{"email": $email,"username": $password}]';
    var jsonString = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Users.json')));
    var l = jsonDecode(jsonString.body);
    return l.values;
  }
  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;
    //var jsonString = '[{"email": $email,"username": $password}]';
    var jsonString = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Users.json')));
    var l = jsonDecode(jsonString.body);
    var m = null;
    MyUser user = null;
  
    for(var i in l.values)
    {
      if(i['Email']==email)
      {
         user = MyUser.fromJson(i); 
        // print(i['Email']);
         //print(i['UserID']);
         break;
      }
    }
  
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await get(
      Uri.parse(AppUrl.login),
      //body: json.encode(user.toMap()),
      //print(body);
      //headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
    if (response.statusCode == 200||response.statusCode==201) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      //var userData = responseData['data'];
      //var jsonString = '{"email":$email,"username":$password}';
      //Map<String, dynamic> userMap = jsonDecode(jsonString);
      //var authuser = MyUser.fromJson(responseData);
      MyUser authUser = user;
      //MyUser.fromJson(responseData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(String email, String firstname, String lastname,String password,String district,String typeofpets, String price,String ready) async {

    var jsonString = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Users.json')));
    var l = jsonDecode(jsonString.body);
    int id = l.length+1;
    final Map<String, dynamic> registrationData = {
        'District':district,
        'Email': email,
        'FirstName':firstname,          //Map<tttt,User>
        'LastName':lastname,
        'Password': password,
        'ReadyForOverposure':ready,
        'UserID': id,
        'TypePets':typeofpets,
        'Price':price,
        
    };
   var response =  await post(Uri.parse(AppUrl.register),
        body: json.encode(registrationData));
        //headers: {'content-type': 'text/plain'})
        //headers: {'Content-Type': 'application/json'})
  MyUser authUser = MyUser(
  userid: registrationData['UserID'], 
  firstname: registrationData['FirstName'],
  lastname:registrationData['LastName'],
  password: registrationData['Password'],
  readyforoverposure: registrationData['ReadyForOverposure'],
  email: registrationData['Email'],
  district: registrationData['District'],
  typePets: registrationData['TypePets'],
  price: registrationData['Price'],
  //stringID: registrationData['StringID']
  //pet: registrationData['Pet'],
  );
  UserPreferences().saveUser(authUser);
  var result;
  if (response.request!=null)
    result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    else{
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': null
      };
    }
    return result;
  }


  static Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    print(response.statusCode);
    if (response.statusCode == 200) {

     var userData = responseData['data'];

      MyUser authUser = MyUser.fromJson(userData);
      UserPreferences().saveUser(authUser);
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }

}
