import 'dart:core';

class Article
{
  //все поля приватные
  int id;
  String title;
  String body;
  String image;
  bool isFav;
  String animal;
  String imageAdress;
  //final String _image;


  
  //String get image =>_image;

  Article({this.id, this.body,this.image,this.title,this.isFav,this.animal,this.imageAdress});
  // Dart позволяет создавать конструкторы с разными именами
  // В данном случае Article.fromJson(json) - это конструктор
  // здесь мы принимаем JSON объект поста и извлекаем его поля
  factory Article.fromJson(Map<String, dynamic> json){
    return Article(
    id: json["articleId"],
    image: json["image"],
    title:json["title"],
    body:json["textOfArticle"],
    isFav: json['isFavourite'],
    animal:json['animal'],
    imageAdress: json['imageAdress'])
    
    
    ;
    }

    Map<String, dynamic> toMap() {
    return (
      {
      "ArticleID": id,
      "Image": image,
      "Title": title,
      "Text": body,
      "IsFav": isFav,
      //'imageAdress':
    }
    );
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