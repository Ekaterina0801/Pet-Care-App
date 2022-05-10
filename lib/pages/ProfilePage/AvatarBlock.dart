import 'package:flutter/material.dart';

class AvatarBlock extends StatefulWidget {
  final String name;
  final String photo;
  AvatarBlock(this.name, this.photo);

  @override
  State<AvatarBlock> createState() => _AvatarBlockState();
}

class _AvatarBlockState extends State<AvatarBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 80,
              backgroundImage: Image.asset(widget.photo).image,
            ),
          ),
          Text(widget.name,
              style: Theme.of(context).copyWith().textTheme.bodyText1),
        ],
      ),
    );
  }
}
