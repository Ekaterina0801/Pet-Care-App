import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../dommain/myuser.dart';

class Overexposure
{
  int overexposureId;
  int userId;
  String animal;
  String oNote;
  int cost;
  MyUser user;

  Overexposure({this.overexposureId,this.userId,this.animal,this.oNote,this.cost,this.user});
  Map<String, dynamic> toMap() {
    return (
      {
      "overexposureId": overexposureId,
      "userId": userId,
      "animal": animal,
      "oNote":oNote,
      "cost":cost,
      "user":user
    }
    );
  }

  factory Overexposure.fromJson(Map<String,Object> json) => Overexposure(
      overexposureId: json['overexposureId'],
      userId: json['userId'],
      animal: json['animal'],
      oNote: json['oNote'],
      cost:json['cost'],
      user:json['user']
  );
  
  Map<String,dynamic> toJson()=>
  {
    'overexposureId':overexposureId,
    'userId':userId,
    'animal':animal,
    'oNote':oNote,
    'cost':cost,
    'user':user,
  };
  
}

Future<List<Overexposure>> getOverexposures() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.get('userId');
    Response res = await http.get(
      Uri.parse(
        Uri.encodeFull(
            'http://vadimivanov-001-site1.itempurl.com/Load/LoadNotes?user_id=$userId'),
      ),
    );

    if (res.statusCode == 200) {
      List<Overexposure> list = [];
      var ll = jsonDecode(res.body);
      for (var t in ll.keys) {
        Overexposure a = Overexposure.fromJson(ll[t]);
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve notes.";
    }
  }

