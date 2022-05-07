import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'Vaccination.dart';

class RepositoryVaccinations {
  Future<List<Vaccination>> getvacc() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull(
        'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Vaccinations.json')));

    if (res.statusCode == 200) {
      //var rb = res.body;
      List<Vaccination> list = [];
      var ll = jsonDecode(res.body);
      for (var t in ll.keys) {
        Vaccination a = Vaccination.fromJson(ll[t]);
        a.vaccinationId = t;
        //if(a.userID==)
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve pets.";
    }
  }

  Future<http.Response> delete(Vaccination v) async {
    return http.delete(
      Uri.parse(Uri.encodeFull(
          'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Vaccinations/' +
              v.vaccinationId +
              '.json')),
      body: jsonEncode(v),
    );
  }
}
