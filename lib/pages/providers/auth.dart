import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pet_care/dommain/myuser.dart';
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

  Future<List<MyUser>> allUsers() async {
    var jsonString = await http.get(Uri.parse(Uri.encodeFull(
        'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Users.json')));
    var l = jsonDecode(jsonString.body);
    return l.values;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;
    var jsonString = await http.get(Uri.parse(Uri.encodeFull(
     'http://vadimivanov-001-site1.itempurl.com/Enter/EnterUserProfile?email=$email&password=$password' )));
    var l;
    if(jsonString.body!="")
       l = jsonDecode(jsonString.body);
    MyUser user;
    if(jsonString.body==null)
      user = null;
    
      if(jsonString.body!="")
      {
        _loggedInStatus = Status.Authenticating;
        user = MyUser.fromJson(l);
      }
       else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        //Login();
      }
    
    // print(i['Email']);
    //print(i['UserID']);

    
    //notifyListeners();

   if(_loggedInStatus==Status.Authenticating) {
     // final Map<String, dynamic> responseData = json.decode(response.body);

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
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(
      String email,
      String firstname,
      String lastname,
      String password,
      String district,
      bool ready) async {
    final Map<String, dynamic> registrationData = {
      'fname': firstname,
      'lname': lastname,
      'email': email, //Map<tttt,User>
      'password': password,
      'district': district,
      'confirmation': ready,
    };
    var response = await post(Uri.parse('http://vadimivanov-001-site1.itempurl.com/Register/RegisterUser'),
        body: json.encode(registrationData),
        headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
        );
    //var js = json.decode(response);
    var jsonString = await http.get(Uri.parse(Uri.encodeFull(
     'http://vadimivanov-001-site1.itempurl.com/Enter/EnterUserProfile?email=$email&password=$password' )));
    var l;
    if(jsonString.body!="")
       l = jsonDecode(jsonString.body);
    MyUser authUser = MyUser.fromJson(l);
    UserPreferences().saveUser(authUser);
    var result;
    if (response.request != null)
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    else {
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
