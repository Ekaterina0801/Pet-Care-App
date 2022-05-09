//Виджет для отображения на странице статьи изображения и заголовка статьи
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  image: Image.network(
                    'https://www.wikihow.com/images/thumb/c/c3/Take-Care-of-Your-Pet-Step-6-Version-2.jpg/v4-728px-Take-Care-of-Your-Pet-Step-6-Version-2.jpg',
                  ).image,
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 223, 142, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 80,
                  width: 200,
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      title,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.comfortaa(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
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
