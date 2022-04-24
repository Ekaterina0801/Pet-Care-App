import 'dart:core';

class Article
{
  //все поля приватные
  int id;
  String title;
  String body;
  String image;
  //final String _image;


  
  //String get image =>_image;

  Article({this.id, this.body,this.image,this.title});
  // Dart позволяет создавать конструкторы с разными именами
  // В данном случае Article.fromJson(json) - это конструктор
  // здесь мы принимаем JSON объект поста и извлекаем его поля
  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
    id: json["ArticleID"],
    image: json["Image"],
    title:json["Title"],
    body:json["Text"])
    ;
    }
    //this._image = json["image"];
}

// ArticleList являются оберткой для массива статей
class ArticleList {
  final List<Article> articles = [];
  ArticleList.fromJson(List<dynamic> jsonItems) {
    for (var jsonItem in jsonItems) {
      articles.add(Article.fromJson(jsonItem));
    }
  }
}

abstract class ArticleResult{}

//указатель на успешный запрос
class ArticleResultSuccess extends ArticleResult {
  final List<Article> articleList;
  ArticleResultSuccess(this.articleList);
}

// произошла ошибка
class ArticleResultFailure extends ArticleResult {
  final String error;
  ArticleResultFailure(this.error);
}

// загрузка данных
class ArticleResultLoading extends ArticleResult {
  ArticleResultLoading();
}