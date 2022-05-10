import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Overexposure {
  int overexposureId;
  int userId;
  String animal;
  String oNote;
  int cost;
  String firstname;
  String lastname;
  String email;
  String district;

  Overexposure(
      {this.overexposureId,
      this.userId,
      this.animal,
      this.oNote,
      this.cost,
      this.firstname,
      this.lastname,
      this.email,
      this.district});
  Map<String, dynamic> toMap() {
    return ({
      "overexposureId": overexposureId,
      "userId": userId,
      "animal": animal,
      "overexposure_note": oNote,
      "cost": cost,
      "first_name": firstname,
      "last_name": lastname,
      "email": email,
      "district":district
    });
  }

  factory Overexposure.fromJson(Map<String, Object> json) => Overexposure(
      overexposureId: json['overexposureId'],
      userId: json['userId'],
      animal: json['animal'],
      oNote: json['overexposure_note'],
      cost: json['cost'],
      firstname: json["first_name"],
      lastname: json["last_name"],
      email: json["email"],
      district: json["district"]);

  Map<String, dynamic> toJson() => {
        'overexposureId': overexposureId,
        'userId': userId,
        'animal': animal,
        'oNote': oNote,
        'cost': cost,
        "first_name": firstname,
        "last_name": lastname,
        "email": email,
        "district":district
      };
}

Future<List<Overexposure>> getOverexposures() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.get('userId');
  Response res = await http.get(
    Uri.parse(
      Uri.encodeFull(
          'http://vadimivanov-001-site1.itempurl.com/Overexposure/LoadOverexposureDataList?user_id=$userId'),
    ),
  );

  if (res.statusCode == 200) {
    List<Overexposure> list = [];
    var l = jsonDecode(res.body);
    List ll = l['offers'];
    for (var t in ll) {
      Overexposure a = Overexposure.fromJson(t);
      list.add(a);
    }
    return list;
  } else {
    throw "Unable to retrieve overexposure.";
  }
}
