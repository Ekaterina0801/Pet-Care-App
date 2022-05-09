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
  final Map<String, dynamic> data = {
    'what':"favourite",  
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
