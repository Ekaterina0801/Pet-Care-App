import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/pages/FeedingCalendarPage.dart';
import 'package:pet_care/pages/NotesPage.dart';
import 'package:pet_care/pages/PetBoardingPage.dart';
import 'package:pet_care/pages/ProfilePage.dart';

import 'AdvicePage.dart';

//базовая страница
class BasePage extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget navigationbar;
  BasePage({this.body, this.title, this.navigationbar = null});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(title),
      ),
      body: body,
      bottomNavigationBar: navigationbar,
    );
  }
}

//виджет навигационной панели
class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
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
        child: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: Colors.white,
            selectedItemBorderColor: Colors.yellow,
            selectedItemBackgroundColor: Colors.green,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black,
          ),
          selectedIndex: currentindex,
          onSelectTab: (index) {
            setState(() {
              currentindex = index;
            });
          },
          items: [
            FFNavigationBarItem(
              iconData: Icons.book,
              label: 'Советы',
            ),
            FFNavigationBarItem(
              iconData: Icons.people,
              label: 'Сервис',
            ),
            FFNavigationBarItem(
              iconData: Icons.calendar_view_day,
              label: 'Календарь',
            ),
            FFNavigationBarItem(
              iconData: Icons.note,
              label: 'Записки',
            ),
            FFNavigationBarItem(
              iconData: Icons.people,
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}
