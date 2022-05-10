import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Meeting.dart';
// импортируем http пакет
import 'package:http/http.dart' as http;

class RepositoryMeetings {
  Future<List<Meeting>> getMeetings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.get('userId');
    Response res = await http.get(Uri.parse(Uri.encodeFull(
        'http://vadimivanov-001-site1.itempurl.com/Load/LoadMentions?user_id=$userId')));

    if (res.statusCode == 200) {
      //var rb = res.body;
      List<Meeting> list = [];
      var ll = jsonDecode(res.body);
      for (var t in ll) {
        Meeting a = Meeting.fromJson(t);
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve meetings.";
    }
  }

  Future<http.Response> delete(Meeting m) async {
    int id = m.mentionId;
    return http.delete(
      Uri.parse(Uri.encodeFull(
          'http://vadimivanov-001-site1.itempurl.com/Delete/DeleteMention?mention_id=$id')),
      body: jsonEncode(m),
      headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
    );
  }
}
