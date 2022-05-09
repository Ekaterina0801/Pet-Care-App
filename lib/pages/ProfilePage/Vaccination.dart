import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:pet_care/pages/ProfilePage/Pet.dart';

class Vaccination {
  int vaccinationId;
  String type;
  String date;
  String document;
  bool revaccination;

  Vaccination(
      {this.vaccinationId,
      this.date,
      this.type,
      this.document,
      this.revaccination});
  factory Vaccination.fromJson(Map<String, Object> json) => Vaccination(
      vaccinationId: json['vaccinationId'],
      date: json['date'],
      type: json['type'],
      document: json['officialDocument'].toString(),
      revaccination: json['necessityOfRevaccination']);

  Map<String, dynamic> toJson() => {
        'vaccinationId': vaccinationId,
        'date': date,
        'type': type,
        'officialDocument': document,
        'necessityOfRevaccination': revaccination
      };
}

Future<List<Vaccination>> getVaccinnations(int userID) async {
  Response res = await http.get(Uri.parse(Uri.encodeFull(
      'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Vaccinations.json')));
  List<Vaccination> vacc = [];
  if (res.statusCode == 200) {
    var ll = jsonDecode(res.body);
    for (var t in ll) {
      vacc.add(t);
    }
  } else {
    throw "Unable to retrieve vaccinations.";
  }
  return vacc;
}

Future<Map<String, dynamic>> addVaccination(
    String date, String type, String document, bool revaccination) async {
  List<Pet> pets = await getPets();
  int petId = pets[0].petId;
  final Map<String, dynamic> dData = {
    'pet_id': petId,
    'type': type,
    'date': date,
    'officialDocument': [],
    'necessityOfRevaccination': revaccination
  };

  var response = await post(
    Uri.parse(
        'http://vadimivanov-001-site1.itempurl.com/Register/RegisterVaccination'),
    body: json.encode(dData),
    headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
  );
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': dData};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
}
