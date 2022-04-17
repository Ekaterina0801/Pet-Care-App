import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/AdviceScreen/AdviceList.dart';

import 'package:pet_care/pages/AdviceScreen/ArticlePage.dart';
import 'package:pet_care/pages/NotesPage/NotesPage.dart';
import 'package:pet_care/pages/Registration/pages/login.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'package:pet_care/pages/providers/auth.dart';
import 'package:pet_care/pages/providers/userprovider.dart';
import 'package:pet_care/pages/Registration/pages/register.dart';
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
            'test':(context)=>DisplayAddNote(),
            '/register': (context) => Register(),
           '/home': (BuildContext context) => HomePage(),
           '/notes':(context) => NotesPage()
          },
        title: 'PetCare',
        //initialRoute: '/login',
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
