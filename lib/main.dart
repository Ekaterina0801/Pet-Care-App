import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/AdviceScreen/AdviceList.dart';

import 'package:pet_care/pages/AdviceScreen/ArticlePage.dart';
import 'package:pet_care/pages/Registration/RegistrationPage.dart';
import 'package:pet_care/pages/login.dart';
import 'package:pet_care/pages/providers/auth.dart';
import 'package:pet_care/pages/providers/userprovider.dart';
import 'package:pet_care/pages/register.dart';
import 'package:pet_care/pages/util/shared_preference.dart';
import 'package:pet_care/pages/welcome.dart';
import 'package:pet_care/repository/advicerepo.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'pages/BasePage.dart';
import 'pages/ProfilePage/ProfilePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    Future<MyUser> getUserData() => UserPreferences().getUser();
    //var t = UserPreferences().getUser();
    //MyUser user = Provider.of<UserProvider>(context).user;
    //print(user.name);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
    child: MaterialApp(
      home: FutureBuilder(
              future: getUserData(),
              
              builder: (context, snapshot) {
               // print(snapshot.data.name);
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (snapshot.data.email== null)
                      return Login();
                    else
                      //UserPreferences().removeUser();
                    return HomePage();
                }
              }),
          routes: {
            '/login': (context) => Login(),
            '/register': (context) => Register(),
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
           '/home': (BuildContext context) => HomePage(),
          },
        title: 'PetCare',
        //initialRoute: '/login',
        /*
        routes: {
          '/test':(BuildContext context)=>ArticleListPage(),
          '/start': (BuildContext context) => ProfilePage(),
          '/home': (BuildContext context) => HomePage(),
          '/login': (BuildContext context) => LoginRegestrationPage(),
          
          //'7': (BuildContext context) => ArticlePage(articles[7]),
        },*/
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
        )));
  }
}
