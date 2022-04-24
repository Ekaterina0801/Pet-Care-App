import 'package:flutter/material.dart';
import 'package:pet_care/pages/AdviceScreen/widget_pages/ArticlePage.dart';
import 'package:pet_care/pages/AdviceScreen/requests/data/repoarticles.dart';
import 'package:pet_care/pages/BasePage.dart';
import 'Advice_Block.dart';
import '../requests/models/Article.dart';

//страница со списком статей
class ArticleListPage extends StatelessWidget {
  final Repository httpService = Repository();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Статьи',
      body: FutureBuilder(
        future: httpService.getArticles(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data;
            return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 193,
                crossAxisSpacing: 2,
                mainAxisSpacing: 1,
              ),
              children: articles
                  .map(
                    (Article article) => AdviceBlock(
                      article.title,
                      article.image,
                      article.id,
                      () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ArticlePage(article),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
