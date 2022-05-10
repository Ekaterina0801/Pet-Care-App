import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/AdviceScreen/widget_pages/ArticlePage.dart';
import '../widgets/Advice_List_Page.dart';
import '../widgets/Advice_Block.dart';
import '../widgets/Main_Advice_Block.dart';
import '../requests/controllers/ArticleController.dart';
import '../requests/models/Article.dart';
import 'ArticlePage.dart';

//главная страница советов
class AdvicePageMain extends StatefulWidget {
  @override
  _AdvicePageState createState() => _AdvicePageState();
}

class _AdvicePageState extends StateMVC {
  ArticleController _controller;
  _AdvicePageState() : super(ArticleController()) {
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
        child: Text(state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.red)),
      );
    } else {
      final articles = (state as ArticleResultSuccess).articleList;
      List<Article> fav = [];
      for (var a in articles) if (a.isFav) fav.add(a);
      return ListView(children: [
        AdviceMainBlock(
          articles[0].title,
          articles[0].imageAdress,
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ArticlePage(articles[0]),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Статьи",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.comfortaa(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 24)),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleListPage(articles),
                  ),
                ),
                child: Text("Показать все",
                    style: Theme.of(context).copyWith().textTheme.titleSmall),
              )
            ],
          ),
        ),
        Container(
          height: 209.0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: articles.length,
            itemBuilder: (context, i) {
              return AdviceBlock(
                articles[i],
                () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ArticlePage(articles[i]),
                  ),
                ),
              );
            },
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Избранное",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.comfortaa(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 24)),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleListPage(fav),
                  ),
                ),
                child: Text("Показать все",
                    style: Theme.of(context).copyWith().textTheme.titleSmall),
              )
            ],
          ),
        ),
        fav.length == 0
            ? Container(
              padding: EdgeInsets.all(10),
              child: Text("Нет избранных постов"))
            : Container(
                height: 209.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fav.length,
                  itemBuilder: (context, i) {
                    return AdviceBlock(fav[i], () {});
                  },
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.horizontal,
                ),
              ),
      ]);
    }
  }
}
