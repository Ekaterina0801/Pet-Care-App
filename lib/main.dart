import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pet_care/pages/AdvicePage/AdviceList.dart';
import 'package:pet_care/pages/AdviceScreen/ArticlePage.dart';
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
        initialRoute: '/home',
        routes: {
          '/test':(BuildContext context)=>ArticleListPage(),
          '/start': (BuildContext context) => ProfilePage(),
          '/home': (BuildContext context) => HomePage(),
          '/login': (BuildContext context) => LoginRegestrationPage(),
          '0': (BuildContext context) => ArticlePage(articless[0]),
          '1': (BuildContext context) => ArticlePage(articless[1]),
          '2': (BuildContext context) => ArticlePage(articless[2]),
          '3': (BuildContext context) => ArticlePage(articless[3]),
          '4': (BuildContext context) => ArticlePage(articless[4]),
          '5': (BuildContext context) => ArticlePage(articless[5]),
          '6': (BuildContext context) => ArticlePage(articless[6]),
          '7': (BuildContext context) => ArticlePage(articless[7]),
          '8': (BuildContext context) => ArticlePage(articless[8]),
          '9': (BuildContext context) => ArticlePage(articless[9]),
          '10': (BuildContext context) => ArticlePage(articless[10]),
          '11': (BuildContext context) => ArticlePage(articless[11]),
          '12': (BuildContext context) => ArticlePage(articless[12]),
          '13': (BuildContext context) => ArticlePage(articless[13]),
          '14': (BuildContext context) => ArticlePage(articless[14]),
          '15': (BuildContext context) => ArticlePage(articless[15]),
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
