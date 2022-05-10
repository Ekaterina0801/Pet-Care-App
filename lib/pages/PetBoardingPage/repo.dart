import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dommain/myuser.dart';
import 'package:http/http.dart' as http;

class RepositoryUsersList {
  Future<List<MyUser>> getUsersList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.get('userId');
    Response res = await http.get(Uri.parse(Uri.encodeFull(
        'http://vadimivanov-001-site1.itempurl.com/Overexposure/LoadOverexposureDataList?user_id=$userId')));

    if (res.statusCode == 200) {
      //var rb = res.body;
      List<MyUser> list = [];
      var ll = jsonDecode(res.body);
      for (var t in ll) {
        MyUser a = MyUser.fromJson(t);
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve users.";
    }
  }
}



/*
  Future<http.Response> delete(Vaccination v) async {
    int id = v.vaccinationId;
    var response = http.delete(
      Uri.parse(Uri.encodeFull(
          'http://vadimivanov-001-site1.itempurl.com/Delete/DeleteVaccination?vaccination_id=$id')),
      body: jsonEncode(v),
      headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
    );
    return response;
  }
}*/
