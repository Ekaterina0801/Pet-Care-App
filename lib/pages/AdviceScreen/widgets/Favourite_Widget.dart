import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_care/pages/AdviceScreen/requests/models/Article.dart';

// импортируем http пакет
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../BasePage.dart';

// ignore: must_be_immutable
class FavouriteWidget extends StatefulWidget {
  Article article;
  FavouriteWidget(this.article);
  @override
  _FavouriteWidgetState createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: (widget.article.isFav
              ? Icon(
                  Icons.star,
                )
              : Icon(Icons.star_border)),
          onPressed: _tapFavorite,
          color: Colors.black,
        )
      ],
    );
  }

  void _tapFavorite() {
    setState(
      () {
        if (widget.article.isFav) {
          deleteFav(widget.article);
          widget.article.isFav = false;
        } else {
          addFav(widget.article);
          widget.article.isFav = true;
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(0),
          ),
        );
      },
    );
  }
}

Future<bool> isFav(Article article) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.get('userId');
  int id = article.id;
  var response = await http.get(
    Uri.parse(Uri.encodeFull(
        'http://vadimivanov-001-site1.itempurl.com/Article/IsArticleFavourite?user_id=$userId&article_id=$id')),
  );
  var t = response.body;
  return t == "true";
}

Future<http.Response> addFav(Article article) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.get('userId');
  final Map<String, dynamic> data = {
    'user_id': userId,
    'article_id': article.id,
  };

  var response = await http.post(
    Uri.parse(Uri.encodeFull(
        'http://vadimivanov-001-site1.itempurl.com/Register/RegisterFavourite')),
    body: jsonEncode(data),
    headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
  );
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': data};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return response;
}

Future<http.Response> deleteFav(Article article) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.get('userId');
  int articleId = article.id;

  var response = await http.delete(
    Uri.parse(Uri.encodeFull(
        'http://vadimivanov-001-site1.itempurl.com/Delete/DeleteFavourite?user_id=$userId&article_id=$articleId')),
    headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
  );
  return response;
}

Future<http.Response> update(Article article) async {
  final Map<String, dynamic> data = {
    'what': "favourite",
    'id': article.id,
    'new_value': !article.isFav,
  };

  var response = await http.post(
    Uri.parse(Uri.encodeFull(
        'http://vadimivanov-001-site1.itempurl.com/Update/UpdateInformation')),
    body: jsonEncode(data),
    headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
  );
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': data};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return response;
}

void updateFav(Article article) {
  update(article);
  //
}
