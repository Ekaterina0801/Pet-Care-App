import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pet_care/pages/AdvicePage/AdvicePage.dart';
import 'package:pet_care/pages/AdvicePage/ArticlePage.dart';
import 'package:pet_care/pages/Registration/RegistrationPage.dart';
import 'package:pet_care/repository/advicerepo.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'pages/BasePage.dart';
import 'pages/ProfilePage/ProfilePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PetCare',
        initialRoute: '/login',
        routes: {
          '/start': (BuildContext context) => ProfilePage(),
          '/home': (BuildContext context) => HomePage(),
          '/login': (BuildContext context) => LoginRegestrationPage(),
          '0': (BuildContext context) => ArticlePage(articles[0]),
          '1': (BuildContext context) => ArticlePage(articles[1]),
          '2': (BuildContext context) => ArticlePage(articles[2]),
          '3': (BuildContext context) => ArticlePage(articles[3]),
          '4': (BuildContext context) => ArticlePage(articles[4]),
          '5': (BuildContext context) => ArticlePage(articles[5]),
          '6': (BuildContext context) => ArticlePage(articles[6]),
          '7': (BuildContext context) => ArticlePage(articles[7]),
          '8': (BuildContext context) => ArticlePage(articles[8]),
          '9': (BuildContext context) => ArticlePage(articles[9]),
          '10': (BuildContext context) => ArticlePage(articles[10]),
          '11': (BuildContext context) => ArticlePage(articles[11]),
          '12': (BuildContext context) => ArticlePage(articles[12]),
          '13': (BuildContext context) => ArticlePage(articles[13]),
          '14': (BuildContext context) => ArticlePage(articles[14]),
          '15': (BuildContext context) => ArticlePage(articles[15]),
          //'7': (BuildContext context) => ArticlePage(articles[7]),
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
