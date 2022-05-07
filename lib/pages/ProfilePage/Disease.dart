import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;




class Disease {
  String diseaseID;
  int petID;
  int userID;
  String type;
  String dateofbeggining;
  String dateofending;

  Disease(
      {this.diseaseID,
      this.userID,
      this.petID,
      this.type,
      this.dateofbeggining,
      this.dateofending});

  factory Disease.fromJson(Map<String, Object> json) => Disease(
        diseaseID: json['DiseaseID'],
        type: json['Type'],
        petID: json['PetID'],
        dateofbeggining: json['DateOfBeggining'],
        dateofending: json['DateOfEnding'],
        userID: json['UserID'],
      );

  Map<String, dynamic> toJson() => {
        'DiseaseID': diseaseID,
        'Type': type,
        'PetID': petID,
        'DateOfBeggining': dateofbeggining,
        'DateOfEnding': dateofending,
        'UserID': userID
      };
}

Future<List<Disease>> getDiseases(int userID) async {
  Response res = await http.get(Uri.parse(Uri.encodeFull(
      'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Diseases.json')));
  Disease(
      diseaseID: "0",
      type: "-",
      petID: 0,
      dateofbeggining: "-",
      dateofending: "-",
      userID: userID);
  List<Disease> vacc = [];
  if (res.statusCode == 200) {
    var ll = jsonDecode(res.body);
    for (var t in ll.keys) {
      vacc.add(ll[t]);
    }
  } else {
    throw "Unable to retrieve diseases.";
  }
  return vacc;
}

