import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/util/appurl.dart';
import 'package:pet_care/pages/util/shared_preference.dart';



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


  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;
    //var jsonString = '[{"email": $email,"username": $password}]';
    var jsonString = await http.get(Uri.parse(Uri.encodeFull('https://jsonplaceholder.typicode.com/users')));
    //Map<String,dynamic> userMap = 
    var l = jsonDecode(jsonString.body);
    var m = null;
    MyUser user = null;
    for(var i in l)
    {
      if(i['email']==email)
      {
         user = MyUser.fromJson(i); 
         print(i['email']);
         print(i['userId']);
         break;
      }
    }
  

    /*
    final Map<String, dynamic> loginData = {
      : {
        'email': email,
        'password': password
      }
    };
*/
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.login),
      body: json.encode(user.toMap()),
      //print(body);
      headers: {'Content-Type': 'application/json'},
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

  Future<Map<String, dynamic>> register(String email, String password, String passwordConfirmation) async {

    final Map<String, dynamic> registrationData = {
      'user': {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      }
    };
    return await post(Uri.parse(AppUrl.register),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
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
//      if (response.statusCode == 401) Get.toNamed("/login");
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