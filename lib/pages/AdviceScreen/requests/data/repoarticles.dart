import 'dart:convert';

// импортируем http пакет
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pet_care/pages/AdviceScreen/requests/models/Article.dart';



const String SERVER = "https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Articles.json";

  class Repository {
  Future<List<Article>> getArticles() async {
    Response res = await http.get(Uri.parse(Uri.encodeFull('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Articles.json')));
    
    if (res.statusCode == 200) {
      List<Article> list=[];
      var ll = jsonDecode(res.body);
      for(var t in ll.keys)
      {
        Article a = Article.fromJson(ll[t]);
        list.add(a);
      }
      return list;
    } else {
      throw "Unable to retrieve articles.";
    }
  }
  }