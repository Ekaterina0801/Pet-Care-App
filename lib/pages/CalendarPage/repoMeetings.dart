import 'dart:convert';

import 'package:http/http.dart';

import 'Meeting.dart';
// импортируем http пакет
import 'package:http/http.dart' as http;


class RepositoryMeetings {
  Future<List<Meeting>> getMeetings() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Meetings.json')));
    
    if (res.statusCode == 200) {
      //var rb = res.body;
      List<Meeting> list=[];
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
       Meeting a = Meeting.fromJson(ll[t]);
        //a.to = "2022-04-25";
        a.id=t;
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve meetings.";
    }
  }

  Future<http.Response> update(String newtext,Meeting m) async {
    m.eventName=newtext;
    return http.put(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Meetings/'+m.id+'.json')),
    body: jsonEncode(m
    ),);
    
    
  }

  Future<http.Response> delete(Meeting m) async {
    return http.delete(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Meetings/'+m.id+'.json')),
    body: jsonEncode(m
    ),);
  }

  }
  