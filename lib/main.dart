import 'package:flutter/material.dart';

import 'pages/BasePage.dart';
import 'pages/ProfilePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PetCare',
        initialRoute: '/home',
        routes: {
          //'/login': (BuildContext context) => AuthorizationPage(),
          '/start': (BuildContext context) => ProfilePage(),
          '/home': (BuildContext context) => HomePage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ));
  }
}
