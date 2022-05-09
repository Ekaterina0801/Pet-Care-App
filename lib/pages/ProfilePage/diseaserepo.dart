import 'dart:convert';

import 'package:http/http.dart';

import 'Disease.dart';
import 'package:http/http.dart' as http;

import 'Pet.dart';

class RepositoryDiseases {
  Future<List<Disease>> getdiseases() async {
    List<Pet> pets = await getPets();
    int petId = pets[0].petId;
    Response res = await http.get(Uri.parse(Uri.encodeFull(
        'http://vadimivanov-001-site1.itempurl.com/Load/LoadIllnesses?pet_id=$petId')));

    if (res.statusCode == 200) {
      List<Disease> list = [];
      var ll = jsonDecode(res.body);
      for (var t in ll) {
        Disease a = Disease.fromJson(t);
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve disease.";
    }
  }

  Future<http.Response> delete(Disease v) async {
    int id = v.diseaseID;
    return http.delete(
      Uri.parse(Uri.encodeFull(
          'http://vadimivanov-001-site1.itempurl.com/Delete/DeleteIllness?illness_id=$id')),
      body: jsonEncode(v),
      headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},

    );
  }
}
