import 'package:flutter/material.dart';

class FavouriteWidget extends StatefulWidget {
  @override
  _FavouriteWidgetState createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget> {
  bool _isFavorited = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: (_isFavorited
              ? Icon(
                  Icons.star,
                )
              : Icon(Icons.star_border)),
          onPressed: _tapFavorite,
          color: Colors.black,
        ),
      ],
    );
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
    return Row(
      children: <Widget>[
        Icon(
          Icons.star,
        )
      ],
    );
  }
}
