import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pet_care/pages/Registration/RegistrationPage.dart';
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
          '/login': (BuildContext context) => LoginRegestrationPage(),
          '/start': (BuildContext context) => ProfilePage(),
          '/home': (BuildContext context) => HomePage(),
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
