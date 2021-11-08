import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/FeedingCalendarPage.dart';
import 'package:pet_care/pages/NotesPage.dart';
import 'package:pet_care/pages/PetBoardingPage.dart';
import 'package:pet_care/pages/ProfilePage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'AdvicePage/AdvicePage.dart';

//базовая страница
class BasePage extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget navigationbar;
  BasePage({this.body, this.title, this.navigationbar = null});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //backgroundColor: Color.fromRGBO(246, 194, 107, 10),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(title,
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 24)),
      ),
      body: body,
      bottomNavigationBar: navigationbar,
      backgroundColor: Color.fromRGBO(238, 224, 203, 10),
    );
  }
}

//виджет навигационной панели
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex = 0;
  final titles = [
    'Советы',
    'Сервис',
    'Календарь',
    'Записки',
    'Профиль',
  ];
  final children = [
    AdvicePage(),
    PetBoardingPage(),
    FeedingCalendarPage(),
    NotesPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: titles[currentindex],
      body: children[currentindex],
      navigationbar: Container(
        child: SalomonBottomBar(
          selectedItemColor: Colors.black,
          currentIndex: currentindex,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(
                CupertinoIcons.book,
                size: 25,
              ),
              title: Text('Советы',
                  style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                  )),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                CupertinoIcons.location,
                size: 25,
              ),
              title: Text('Сервис',
                  style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                  )),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                CupertinoIcons.calendar,
                size: 25,
              ),
              title: Text('Календарь',
                  style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                  )),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                CupertinoIcons.pen,
                size: 25,
              ),
              title: Text('Записки',
                  style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                  )),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                CupertinoIcons.person,
                size: 25,
              ),
              title: Text('Профиль',
                  style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
