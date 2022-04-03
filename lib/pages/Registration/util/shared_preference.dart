
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/ProfilePage/Pet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
class UserPreferences {
  Future<bool> saveUser(MyUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('userId', user.userid);
    prefs.setString('firstname', user.firstname);
    prefs.setString('lastname', user.lastname);
    prefs.setString('email', user.email);
    prefs.setString('password',user.password);
    prefs.setString('district',user.district);
    prefs.setString('readyforoverposure',user.readyforoverposure);
    //prefs.set
    //prefs.setStringList('vaccinations');
    print("object prefere");

    // ignore: deprecated_member_use
    return prefs.commit();
  }

  Future<MyUser> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt('userId');
    String firstname = prefs.getString('firstname');
    String email = prefs.getString('email');
    String password = prefs.getString('password');
    String lastname = prefs.getString('lastname');
    String district = prefs.getString('district');
    String readyforoverposure = prefs.getString('readyforoverposure');
    print(email);
    print(lastname);
    print(password);
    print("OK");
   
    return MyUser(
        userid: userId,
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
        district: district,
        readyforoverposure: readyforoverposure
       );
  }
  
  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("firstname");
    prefs.remove('userid');
    prefs.remove('lastname');
    prefs.remove("email");
    prefs.remove("district");
    prefs.remove("password");
    prefs.remove("readyforoverposure");
  }
  Future<String> getId(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("userid");
    return id;
  }
}

Future<Pet> getUserID() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('userId');
}
