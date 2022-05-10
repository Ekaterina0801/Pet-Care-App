import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdviceMainBlock extends StatelessWidget {
  final String title;
  final String image;
  final void Function() tap;

  AdviceMainBlock(this.title, this.image, this.tap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: const Offset(0.0, 0.0),
                spreadRadius: 2.0,
              )
            ]),
        margin: EdgeInsets.all(15),
        //padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FadeInImage.assetNetwork(
                      image: image,
                      placeholder: 'assets/article_1.1.jpg',
                    ).image,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 223, 142, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 60,
                  width: 200,
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(title,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 16)),
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
