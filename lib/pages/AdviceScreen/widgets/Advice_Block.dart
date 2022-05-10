import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../requests/models/Article.dart';
import 'Favourite_Widget.dart';

//Виджет - блок совета
// ignore: must_be_immutable
class AdviceBlock extends StatelessWidget {
  Article article;
  final void Function() tap;

  AdviceBlock(this.article, this.tap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: const Offset(0.0, 0.0),
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 110,
              width: 200,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Align(
                  child: FavouriteWidget(article),
                  alignment: Alignment.topRight,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FadeInImage.assetNetwork(
                    image: article.imageAdress,
                    placeholder: 'assets/article_1.1.jpg',
                  ).image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 223, 142, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 60,
                  width: 200,
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      article.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
