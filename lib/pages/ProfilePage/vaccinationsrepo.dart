import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care/pages/ProfilePage/Pet.dart';
import 'Vaccination.dart';

class RepositoryVaccinations {
  Future<List<Vaccination>> getvacc() async {
    List<Pet> pets = await getPets();
    int petId = pets[0].petId;
    Response res = await http.get(Uri.parse(Uri.encodeFull(
        'http://vadimivanov-001-site1.itempurl.com/Load/LoadVaccinations?pet_id=$petId')));

    if (res.statusCode == 200) {
      //var rb = res.body;
      List<Vaccination> list = [];
      var ll = jsonDecode(res.body);
      for (var t in ll) {
        Vaccination a = Vaccination.fromJson(t);
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve vaccinations.";
    }
  }

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
}
