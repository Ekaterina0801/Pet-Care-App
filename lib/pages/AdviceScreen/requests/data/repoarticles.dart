import 'dart:convert';

// импортируем http пакет
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pet_care/pages/AdviceScreen/requests/models/ArticleJ.dart';



const String SERVER = "https://jsonplaceholder.typicode.com";

  class Repository {
  Future<List<Article>> getArticles() async {
    Response res = await get(Uri.parse("$SERVER/posts"));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Article> articles = body
        .map(
          (dynamic item) => Article.fromJson(item),
        )
        .toList();

      return articles;
    } else {
      throw "Unable to retrieve articles.";
    }
  }
  }