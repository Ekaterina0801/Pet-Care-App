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
  _AdvicePageState():super(ArticleController()){
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
    } else {
      
      final articles = (state as ArticleResultSuccess).articleList;
    return ListView(children: [
      AdviceMainBlock(articles[0].title, articles[0].image,() => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ArticlePage(
                            articles[0]
                          ),
                        ),
                      ),),
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
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ArticleListPage())),
              child: Text("Показать все",
                  style: GoogleFonts.comfortaa(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 14)),
            )
          ],
        ),
      ),
      Container(
        height: 209.0,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, i) {
            return AdviceBlock(articles[i].title, articles[i].image, articles[i].id,() => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ArticlePage(
                            articles[i]
                          ),
                        ),
                      ),);
          },
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
        ),
      ),
      /*
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
                      builder: (context) => ArticleListPage())),
              child: Text("Показать все",
                  style: GoogleFonts.comfortaa(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 14)),
            )
          ],
        ),
      ),
      Container(
        height: 209.0,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, i) {
            return AdviceBlock(articles[i].title, articles[i].image, articles[i].id,(){});
          },
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
        ),
      ),*/
    ]);
  }
}
}