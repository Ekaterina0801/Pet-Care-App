import 'dart:convert';

import 'package:http/http.dart';

import 'Disease.dart';
import 'package:http/http.dart' as http;

class RepositoryDiseases {
  Future<List<Disease>> getdiseases() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull(
        'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Diseases.json')));

    if (res.statusCode == 200) {
      List<Disease> list = [];
      var ll = jsonDecode(res.body);
      for (var t in ll.keys) {
        Disease a = Disease.fromJson(ll[t]);
        a.diseaseID = t;
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve pets.";
    }
  }

  Future<http.Response> delete(Disease v) async {
    return http.delete(
      Uri.parse(Uri.encodeFull(
          'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Diseases/' +
              v.diseaseID +
              '.json')),
      body: jsonEncode(v),
    );
  }
}
