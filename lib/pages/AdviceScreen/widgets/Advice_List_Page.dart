import 'package:flutter/material.dart';
import 'package:pet_care/pages/AdviceScreen/widget_pages/ArticlePage.dart';
import 'package:pet_care/pages/AdviceScreen/requests/data/repoarticles.dart';
import 'package:pet_care/pages/BasePage.dart';
import 'Advice_Block.dart';
import '../requests/models/Article.dart';

//страница со списком статей
class ArticleListPage extends StatefulWidget {
  List<Article> articles;
  ArticleListPage(this.articles);
  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  final Repository httpService = Repository();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Статьи',
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 193,
          crossAxisSpacing: 2,
          mainAxisSpacing: 1,
        ),
        children: widget.articles
            .map(
              (Article article) => AdviceBlock(
                article,
                () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ArticlePage(article),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
