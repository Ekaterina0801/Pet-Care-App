import 'dart:convert';

import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'package:pet_care/pages/providers/auth.dart';
import 'package:pet_care/pages/providers/userprovider.dart';
import 'package:pet_care/repository/accounts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'AccountBlock.dart';
import 'SettingsService.dart';

//страница сервиса передержки
class PetBoardingPage extends StatefulWidget {
  @override
  _PetBoardingPageState createState() => _PetBoardingPageState();
}

class _PetBoardingPageState extends StateMVC {
  MyUserController _controller;
  _PetBoardingPageState():super(MyUserController())
  {
    _controller = controller as MyUserController;
  }
   @override
  void initState() {
    super.initState();
    _controller.init();
  }

  //final formKey = new GlobalKey<FormState>();
  MyUser user;
  var _selected_info = "";
  @override
  Widget build(BuildContext context) {
    Future<MyUser> getUserData() => UserPreferences().getUser();
    final state = _controller.currentState;
    if (state is MyUserResultLoading) {
      // загрузка
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is MyUserResultFailure) {
      // ошибка
      return Center(
        child: Text(state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.red)),
      );
    } else {
      final l = (state as MyUserResultSuccess).usersList;
      final k = [];
      for(var t in l)
      {
        if(t.readyforoverposure=="Да")
          k.add(t);
      }
    return MultiProvider(
      providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => UserProvider()),
          ],
      child: FutureBuilder(
        future:getUserData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      user = snapshot.data;
          return ListView(
            physics: ScrollPhysics(),
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 223, 142, 10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: const Offset(0.0, 0.0),
                          spreadRadius: 0.0,
                        )
                      ]),
                  child: Column(children: [
                    Container(
                      child: Avatar(
                        name: user.firstname+" "+user.lastname,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(user.firstname+" "+user.lastname,
                          maxLines: 12,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.comfortaa(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                              fontSize: 18)),
                    ),
                    /*
                    Container(
                        child: TextButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SettingsService())),
                      child: Text("Перейти к настройкам моего профиля для сервиса",
                          style: GoogleFonts.comfortaa(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                              fontSize: 14)),
                    )
                    ),*/
                  ])),
              Row(
                children: [
                
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Кто готов взять питомцев на передержку: ",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  )
                ],
              ),
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 255,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: k.length,
                  itemBuilder: (BuildContext context, int index) =>
                      Container(child: AccountBlock(k[index], index))),
            ],
          );
        }
        }),
    );
        }}

  double _value = 20;
  _displayFilter(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(
        'Фильтр: ',
        style: GoogleFonts.comfortaa(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w800,
            fontSize: 18),
      ),
      actions: [
        FlatButton(
          child: Text(
            'Принять',
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 14),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      content: Column(
        children: [
          Container(
            //width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                "(Фильтр с заглушками, на стадии разработки)",
                style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            ),
          ),
          Container(
            //width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                "Вид животного",
                style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Собаки',
                      style: GoogleFonts.comfortaa(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    ),
                    Icon(Icons.check_box_outlined, size: 20)
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    'Кошки',
                    style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                  Icon(Icons.check_box_outlined, size: 20)
                ],
              )
            ],
          ),
          Text(
            "Стоимость",
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 16),
          ),
          Slider(
            divisions: 3000,
            label: '${_value.round()}',
            thumbColor: Color.fromRGBO(255, 223, 142, 10),
            activeColor: Color.fromRGBO(255, 223, 142, 10),
            min: 0.0,
            max: 3000.0,
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          )
        ],
      ),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
