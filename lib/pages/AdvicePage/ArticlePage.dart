import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/AdvicePage/AdviceWidget.dart';
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
          AdviceBlock(article.title, article.image, 0),
          Container(
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
        ]
            //appBar: AppBar(
            // title: Text('Cоветы',
            //textAlign: TextAlign.left,
            //style: TextStyle(
            //fontSize: 20,
            //fontWeight: FontWeight.w400,
            // color: Colors.white)),
            ));
  }
}
