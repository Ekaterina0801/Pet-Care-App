import 'dart:convert';

import 'package:pet_care/pages/AdviceScreen/requests/models/Article.dart';

import '../requests/models/Article.dart';

class ArticleMapper
{
  static Article articlefromApi(ApiArticle article){
    dynamic data = json.decode(article.data);
    return Article.fromJson(data);
  }
}

class ApiArticle{
  String data;

  ApiArticle.fromApi(this.data);
}