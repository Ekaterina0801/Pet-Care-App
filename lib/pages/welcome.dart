import 'package:flutter/material.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/providers/userprovider.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  final MyUser user;

  Welcome({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).setUser(user);

    return Scaffold(
      body: Container(
        child: Center(
          child: Text("WELCOME PAGE"),
        ),
      ),
    );
  }
}