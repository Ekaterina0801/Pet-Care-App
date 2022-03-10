import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/BasePage.dart';
import 'package:pet_care/repository/advicerepo.dart';

import 'Article.dart';
import 'requests/controllers/ArticleController.dart';
import 'requests/models/ArticleJ.dart';

//Страница статьи
class ArticlePage extends StatefulWidget {
  final ArticleTest article;
  ArticlePage(this.article);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends StateMVC {

  ArticleController _controller;
  _ArticlePageState():super(ArticleController())
  {
    _controller = controller as ArticleController;
  }
  @override
  void initState() {
    super.initState();
    _controller.init();
  }
  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is ArticleResultLoading) {
      // загрузка
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is ArticleResultFailure) {
      // ошибка
      return Center(
        child: Text(
          state.error,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.red)
        ),
      );
    } else{
    final articles = (state as ArticleResultSuccess).articleList.articles;
    return BasePage(
        title: 'Советы',
        body: ListView(children: [
          ArticleBlock(articles[0].title, articless[0].image),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            color: Color.fromRGBO(255, 223, 142, 100),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Text(articles[0].body,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16)),
              ),
            ),
          )
        ]));
  }}
}

//Виджет лля отображения на странице статьи изображения и заголовка статьи
class ArticleBlock extends StatelessWidget {
  final String title;
  final String image;
  ArticleBlock(this.title, this.image);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 250,
              width: 1000,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(
                      image,
                    ).image,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 223, 142, 1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: 200,
                    padding: EdgeInsets.all(5),
                    child: Center(
                        child: Text(title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.comfortaa(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w800,
                                fontSize: 14))),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
