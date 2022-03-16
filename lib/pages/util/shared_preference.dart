
import 'package:pet_care/dommain/myuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future<bool> saveUser(MyUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('userId', user.id);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('password',user.password);


    print("object prefere");

    // ignore: deprecated_member_use
    return prefs.commit();
  }

  Future<MyUser> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt('userId');
    String name = prefs.getString('name');
    String email = prefs.getString('email');
    String password = prefs.getString('password');
    print(email);
    print(name);
    print(password);
    print("OK");
    return MyUser(
        id: userId,
        name: name,
        email: email,
        password: password
       );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("type");
    prefs.remove("token");
  }
  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}