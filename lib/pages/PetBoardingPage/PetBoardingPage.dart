import 'package:avatars/avatars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/repository/accounts.dart';

import 'AccountBlock.dart';
import 'SettingsService.dart';

//страница сервиса передержки
class PetBoardingPage extends StatefulWidget {
  @override
  State<PetBoardingPage> createState() => _PetBoardingPageState();
}

class _PetBoardingPageState extends State<PetBoardingPage> {
  var _selected_info = "";
  @override
  Widget build(BuildContext context) {
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
                  name: accounts[0].name,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(accounts[0].name,
                    maxLines: 12,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 18)),
              ),
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
              )),
            ])),
        Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                  padding: EdgeInsets.all(10),
                  //height: 30,
                  child: IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: () => _displayFilter(context),
                  )),
            ),
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
            itemCount: accounts.length,
            itemBuilder: (BuildContext context, int index) =>
                Container(child: AccountBlock(accounts[index], index))),
      ],
    );
  }

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
            'Ок',
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
            width: MediaQuery.of(context).size.width - 10,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      '0-500',
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
                    '501-1000',
                    style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                  Icon(Icons.check_box_outlined, size: 20)
                ],
              ),
              Column(
                children: [
                  Text(
                    '1001-1500',
                    style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                  Icon(
                    Icons.check_box_outlined,
                    size: 20,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    '>1500',
                    style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                  Icon(
                    Icons.check_box_outlined,
                    size: 20,
                  )
                ],
              )
            ],
          ),
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
