import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_care/pages/AdviceScreen/requests/models/Article.dart';

// импортируем http пакет
import 'package:http/http.dart' as http;
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
        ),
      ],
    );
  }

  void _tapFavorite() {
    setState(
      () {
        if (widget.article.isFav) {
          updateFav(widget.article);
        } else {
          updateFav(widget.article);
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

Future<http.Response> update(Article article) async {
  article.isFav = !article.isFav;
  return http.put(
    Uri.parse(Uri.encodeFull(
        'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Articles/' +
            article.id +
            '.json')),
    body: jsonEncode(article.toMap()),
  );
}

void updateFav(Article article) {
  update(article);
  //
}
