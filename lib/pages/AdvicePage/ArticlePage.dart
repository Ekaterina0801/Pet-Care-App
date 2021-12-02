import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/BasePage.dart';

import 'Article.dart';

class ArticlePage extends StatelessWidget {
  final Article article;
  ArticlePage(this.article);
  @override
  Widget build(BuildContext context) {
    return BasePage(
        title: 'Советы',
        body: ListView(children: [
          ArticleBlock(article.title, article.image),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            color: Colors.grey.withOpacity(0.25),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Text(article.text,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 14)),
              ),
            ),
          )
        ]));
  }
}

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
