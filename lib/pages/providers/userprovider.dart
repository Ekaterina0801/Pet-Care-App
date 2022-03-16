import 'package:flutter/foundation.dart';
import 'package:pet_care/dommain/myuser.dart';


class UserProvider with ChangeNotifier {
  MyUser _user = new MyUser();

  MyUser get user => _user;

  void setUser(MyUser user) {
    _user = user;
    Future.delayed(Duration.zero,(){
       //your code goes here
       notifyListeners();
  });

    
  }
}