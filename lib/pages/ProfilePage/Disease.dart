import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;




class Disease {
  int diseaseID;
  String type;
  String dateofbeggining;
  String dateofending;

  Disease(
      {this.diseaseID,
      this.type,
      this.dateofbeggining,
      this.dateofending});

  factory Disease.fromJson(Map<String, Object> json) => Disease(
        diseaseID: json['illnessId'],
        type: json['type'],
        dateofbeggining: json['dateOfBegining'],
        dateofending: json['dateOfEnding'],
      );

  Map<String, dynamic> toJson() => {
        'illnessId': diseaseID,
        'type': type,
        'dateOfBegining': dateofbeggining,
        'dateOfEnding': dateofending,
      };
}

Future<List<Disease>> getDiseases(int userID) async {
  Response res = await http.get(Uri.parse(Uri.encodeFull(
      'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Diseases.json')));
  Disease(
      diseaseID: 0,
      type: "-",
      dateofbeggining: "-",
      dateofending: "-",
      );
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

