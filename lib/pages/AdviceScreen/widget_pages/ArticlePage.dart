import 'package:flutter/material.dart';
import 'package:pet_care/pages/BasePage.dart';
import '../widgets/Article_Block.dart';
import '../requests/models/Article.dart';

//Страница статьи
class ArticlePage extends StatelessWidget {
  final Article article;
  ArticlePage(this.article);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Статья',
      body: ListView(
        children: [
          ArticleBlock(article.title, article.imageAdress),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            color: Color.fromRGBO(255, 223, 142, 100),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  article.body,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).copyWith().textTheme.bodyText1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
