import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/BasePage.dart';
import 'package:pet_care/pages/ProfilePage/AvatarBlock.dart';
import 'package:pet_care/pages/ProfilePage/MainInfoBlock.dart';
import 'package:pet_care/pages/ProfilePage/Passport.dart';
import 'package:pet_care/pages/ProfilePage/Pet.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'package:pet_care/pages/providers/auth.dart';
import 'package:pet_care/pages/providers/userprovider.dart';
import 'package:pet_care/repository/profilespetsrepo.dart';
import 'package:provider/provider.dart';

import 'AddAnimal.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends StateMVC{
  PetController _controller;
  _ProfilePageState():super(PetController()){
    _controller = controller as PetController;
  }
  @override
  void initState() {
    super.initState();
    _controller.init();
  }
  final formKey = new GlobalKey<FormState>();
  MyUser user;
  Pet pet;

  @override
  
  Widget build(BuildContext context) {
    Future<MyUser> getUserData() => UserPreferences().getUser();
  final state = _controller.currentState;
  if (state is PetResultLoading) {
      // загрузка
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is PetResultFailure) {
      // ошибка
      return Center(
        child: Text(
          state.error,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.red)
        ),
      );
    } else {   
      final pets = (state as PetResultSuccess).petsList;
  //UserPreferences().getUser().then((value) => user=value)
  //Future<MyUser> getUserData() => UserPreferences().getUser();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: 
    FutureBuilder(
      
      future: getUserData(),
      builder: (context,snapshot) {
        switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else user=snapshot.data;

        //final pets = (state as PetResultSuccess).petsList;
        pet = Pet(
        petID: 1,
        userID: user.userid,
        animal:"-",
        name:"-",
        breed:"-",
        dateofbirthday: "-",
        gender: "-",
        weight: 0,
        color:"-"
      );
        for(var i in pets)
        {
        if(i.userID==user.userid)
        {
          pet = i;
          break;
        }
        }
        return 
        pet.weight==0?Column(
          children: [
            Container(
              child: TextButton(
                onPressed: () => 
                Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddAnimal(
                           
                          ),
                        ),
                      ),
                child: Text("Добавить данные о питомце"),
              ),
            )
          ],
        ):ListView(children: [
          
          Container(
            decoration:
                BoxDecoration(color: Color.fromRGBO(255, 223, 142, 10), boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                offset: const Offset(0.0, 0.0),
                spreadRadius: 0.0,
              )
            ]),
            padding: EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              AvatarBlock(pet.name, profilespets[1].photo),
              /*
              Column(
                children: [
                  Container(
                      child: Icon(
                        CupertinoIcons.add,
                        size: 55,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 240, 240, 1),
                          //color: Color.fromRGBO(255, 223, 142, 10),
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      height: 70,
                      width: 70),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Добавить",
                      style: GoogleFonts.comfortaa(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 12),
                    ),
                  )
                ],
              )*/
            ]),
          ),
          Row(children: [Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Основные данные",
              textAlign: TextAlign.center,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
          ),
          FloatingActionButton(
  child: Icon(
    Icons.edit,
    color: Colors.grey),
  backgroundColor: Colors.white,
  onPressed: () {},
), ]),
          Container(
            margin: EdgeInsets.all(8),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainInfoBlock("Возраст", pet.dateofbirthday,
                    Color.fromRGBO(131, 184, 107, 80)),
                MainInfoBlock(
                  "Вес",
                  pet.weight.toString(),
                  Color.fromRGBO(255, 223, 142, 10),
                ),
                // MainInfoBlock("Порода", "Корги", Color.fromRGBO(131, 184, 107, 60)),
                MainInfoBlock("Пол", pet.gender, Color.fromRGBO(129, 181, 217, 90)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Паспорт питомца",
              textAlign: TextAlign.center,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 0, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Passport(user.firstname+" "+user.lastname, pet.dateofbirthday, pet.breed, pet.color,
                    "Прививка от бешенства", "Нет"),
              ],
            ),
          ),
        ]);
      }
      }
      )
    );
   
}
}

}