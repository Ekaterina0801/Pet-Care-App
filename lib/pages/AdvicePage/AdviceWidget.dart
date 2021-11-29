import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Article.dart';

class AdviceWidget extends StatelessWidget {
  final Article article;
  AdviceWidget(this.article);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        children: [
          Container(
            child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Text(article.text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset(article.image).image,
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
        ],
      )
    ]);
  }
}

class AdviceBlock extends StatelessWidget {
  final String title;
  final String image;
  final int index;

  AdviceBlock(this.title, this.image, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '$index');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 100,
              width: 200,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Align(
                  child: FavouriteWidget(),
                  alignment: Alignment.topRight,
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(
                      image,
                    ).image,
                    fit: BoxFit.cover,
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
                    height: 70,
                    width: 200,
                    padding: EdgeInsets.all(5),
                    child: Text(title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800,
                            fontSize: 14)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class AdviceMainBlock extends StatelessWidget {
  final String title;
  final String image;
  AdviceMainBlock(this.title, this.image);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(
                      image,
                    ).image,
                    fit: BoxFit.cover,
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
                    child: Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800,
                            fontSize: 14)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class FavouriteWidget extends StatefulWidget {
  @override
  _FavouriteWidgetState createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget> {
  bool _isFavorited = false;
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      IconButton(
        icon: (_isFavorited
            ? Icon(
                Icons.star,
              )
            : Icon(Icons.star_border)),
        onPressed: _tapFavorite,
        color: Colors.black,
      ),
    ]);
  }

  void _tapFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }
}
