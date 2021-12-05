import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Виджет - блок совета
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
            ]),
        //padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 100,
              width: 200,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Align(
                  child: index == 0 || index == 1
                      ? FavouriteWidgetNotActive()
                      : FavouriteWidget(),
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
                    height: 70,
                    width: 200,
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: Text(title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.comfortaa(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                              fontSize: 14)),
                    ),
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
      onTap: () {
        Navigator.pushNamed(context, '0');
      },
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
                    image: Image.asset(
                      image,
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
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.comfortaa(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                              fontSize: 14)),
                    ),
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

class FavouriteWidgetNotActive extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Icon(
        Icons.star,
      )
    ]);
  }
}
