import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Vaccination {
  String vaccinationId;
  int userID;
  String petId;
  String type;
  String date;
  String document;
  bool revaccination;

  Vaccination(
      {this.vaccinationId,
      this.userID,
      this.petId,
      this.date,
      this.type,
      this.document,
      this.revaccination});
  factory Vaccination.fromJson(Map<String, Object> json) => Vaccination(
      userID: json['UserID'],
      vaccinationId: json['VaccinationID'],
      petId: json['PetID'],
      date: json['Date'],
      type: json['Type'],
      document: json['Document'],
      revaccination: json['Revaccination']);

  Map<String, dynamic> toJson() => {
        'UserID': userID,
        'VaccinationID': vaccinationId,
        'PetID': petId,
        'Date': date,
        'Type': type,
        'Document': document,
        'Revactination': revaccination
      };
}

Future<List<Vaccination>> getVaccinnations(int userID) async {
  Response res = await http.get(Uri.parse(Uri.encodeFull(
      'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Vaccinations.json')));
  Vaccination(
    userID: userID,
    vaccinationId: "-",
    petId: "-",
    date: "-",
    type: "-",
    document: "-",
    revaccination: false,
  );
  List<Vaccination> vacc = [];
  if (res.statusCode == 200) {
    var ll = jsonDecode(res.body);
    for (var t in ll.keys) {
      
      vacc.add(ll[t]);
    }
  } else {
    throw "Unable to retrieve vaccinations.";
  }
  return vacc;
}


Future<Map<String, dynamic>> addVaccination(
    String vaccinationId,
    int userID,
    String petID,
    String date,
    String type,
    String document,
    bool revaccination) async {
  final Map<String, dynamic> dData = {
    'Type': type,
    'VaccinationID': vaccinationId,
    'UserID': userID,
    'PetID': petID,
    'Date': date,
    'Document': "-",
    'Revaccination': revaccination
  };

  var response = await post(
      Uri.parse(
          'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Vaccinations.json'),
      body: json.encode(dData));
  Vaccination vac = Vaccination(
      type: dData['Type'],
      vaccinationId: dData['VaccinationID'],
      petId: dData['PetID'],
      date: dData['Date'],
      document: dData['Document'],
      revaccination: dData['Revaccination'],
      userID: dData['UserID']);
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': vac};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
}
