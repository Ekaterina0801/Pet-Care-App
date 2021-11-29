import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/AdvicePage/AdviceList.dart';
import 'package:pet_care/pages/AdvicePage/AdviceWidget.dart';
import 'package:pet_care/pages/AdvicePage/ArticlePage.dart';
import 'package:pet_care/pages/NotesPage/NotesPage.dart';
import 'package:pet_care/repository/advicerepo.dart';

import '../CalendarPage/FeedingCalendarPage.dart';

class AdvicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      AdviceMainBlock(articles[0].title, articles[0].image),
      Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Статьи",
                textAlign: TextAlign.left,
                style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 24)),
            TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdviceList())),
              child: Text("Показать все",
                  style: GoogleFonts.comfortaa(
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 14)),
            )
          ],
        ),
      ),
      Container(
        height: 210.0,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, i) {
            return AdviceBlock(articles[i].title, articles[i].image, 0);
          },
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Избранное",
                textAlign: TextAlign.left,
                style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 24)),
            Text("Показать все",
                style: GoogleFonts.comfortaa(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 14)),
          ],
        ),
      ),
      Container(
        height: 260.0,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, i) {
            return AdviceBlock(articles[i].title, articles[i].image, 0);
          },
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
        ),
      ),
    ]);
  }
}
