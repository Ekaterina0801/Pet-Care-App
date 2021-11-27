import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'pages/AdvicePage/ArticlePage.dart';
import 'pages/BasePage.dart';
import 'pages/ProfilePage/ProfilePage.dart';
import 'repository/advicerepo.dart';

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
          '1': (BuildContext context) => ArticlePage(articles[1]),
          '2': (BuildContext context) => ArticlePage(articles[2]),
          '3': (BuildContext context) => ArticlePage(articles[3]),
          '4': (BuildContext context) => ArticlePage(articles[4]),
        },
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          SfGlobalLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('ru'),
          const Locale('en'),
        ],
        locale: Locale('ru'),
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ));
  }
}
