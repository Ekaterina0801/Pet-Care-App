import 'dart:convert';

// импортируем http пакет
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pet_care/pages/AdviceScreen/requests/models/Article.dart';
import 'package:pet_care/pages/NotesPage/widgets/NotesPage.dart';
import 'package:shared_preferences/shared_preferences.dart';



const String SERVER = "https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Articles.json";

  class Repository {
  Future<List<Article>> getArticles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.get('userId');
    Response res = await http.get(Uri.parse(Uri.encodeFull('http://vadimivanov-001-site1.itempurl.com/Article/LoadArticles?user_id=$userId')));
    
    if (res.statusCode == 200) {
      List<Article> list=[];
      List ll = jsonDecode(res.body);

      for(var t in ll)
      {
        Article a = Article.fromJson(t);
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve articles.";
    }
  }
  }