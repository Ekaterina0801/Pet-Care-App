import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/CalendarPage/FeedingCalendarPage.dart';
import 'package:pet_care/pages/NotesPage/NotesPage.dart';
import 'package:pet_care/pages/PetBoardingPage/PetBoardingPage.dart';
import 'package:pet_care/pages/ProfilePage/ProfilePage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'AdviceScreen/AdvicePage.dart';




//базовая страница
class BasePage extends StatefulWidget {
  final String title;
  final Widget body;
  final Widget navigationbar;
  BasePage({this.body, this.title, this.navigationbar = null});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          actions: [],
          shadowColor: Colors.grey,
          backgroundColor: Color.fromRGBO(255, 223, 142, 10),
          elevation: (widget.title == 'Профиль') || (widget.title == 'Сервис') ? 0 : 2,
          title: Text(widget.title,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 24)), automaticallyImplyLeading: ((widget.title == 'Статья')  || (widget.title == 'Болезни') || (widget.title == 'Статьи')||(widget.title=='Регистрация'))?  true : false,
        ),
        body: widget.body,
        bottomNavigationBar: widget.navigationbar,
        backgroundColor: Colors.white);
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
    'Календарь (в разработке)',
    'Записки',
    'Профиль',
  ];
  final children = [
    AdvicePage(),
    PetBoardingPage(),
    CalendarPage(),
    NotesPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: titles[currentindex],
      body: children[currentindex],
      navigationbar: SalomonBottomBar(
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
              size: 23,
            ),
            title: Text('Советы',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.location,
              size: 23,
            ),
            title: Text('Сервис',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.calendar,
              size: 23,
            ),
            title: Text('Календарь',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.pen,
              size: 23,
            ),
            title: Text('Записки',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.person,
              size: 23,
            ),
            title: Text('Профиль',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
        ],
      ),
    );
  }
}

/*
//виджет навигационной панели
class HomeNotes extends StatefulWidget {
  @override
  _HomeNotesState createState() => _HomeNotesState();
}

class _HomeNotesState extends State<HomeNotes> {
  int currentindex = 3;
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
    CalendarPage(),
    NotesPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: titles[currentindex],
      body: children[currentindex],
      navigationbar: SalomonBottomBar(
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
              size: 23,
            ),
            title: Text('Советы',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.location,
              size: 23,
            ),
            title: Text('Сервис',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.calendar,
              size: 23,
            ),
            title: Text('Календарь',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.pen,
              size: 23,
            ),
            title: Text('Записки',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.person,
              size: 23,
            ),
            title: Text('Профиль',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          
        ],
      ),
    );
  }
}

//виджет навигационной панели
class HomeProfile extends StatefulWidget {
  @override
  _HomeProfileState createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  int currentindex = 4;
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
    CalendarPage(),
    NotesPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: titles[currentindex],
      body: children[currentindex],
      navigationbar: SalomonBottomBar(
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
              size: 23,
            ),
            title: Text('Советы',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.location,
              size: 23,
            ),
            title: Text('Сервис',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.calendar,
              size: 23,
            ),
            title: Text('Календарь',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.pen,
              size: 23,
            ),
            title: Text('Записки',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              CupertinoIcons.person,
              size: 23,
            ),
            title: Text('Профиль',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                )),
          ),
          
        ],
      ),
    );
  }
}*/
