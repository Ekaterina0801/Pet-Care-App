import 'dart:core';

class Article
{
  //все поля приватные
  final int _articleId;
  final int _id;
  final String _title;
  final String _body;
  //final String _image;

  //getters для полей (для чтения)
  int get articleId=>_articleId;
  int get id => _id;
  String get title =>_title;
  String get body=>_body;
  //String get image =>_image;

  // Dart позволяет создавать конструкторы с разными именами
  // В данном случае Article.fromJson(json) - это конструктор
  // здесь мы принимаем JSON объект поста и извлекаем его поля
  Article.fromJson(Map<String, dynamic> json) :
    this._articleId = json["userId"],
    this._id = json["id"],
    this._title = json["title"],
    this._body = json["body"];
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
  final ArticleList articleList;
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