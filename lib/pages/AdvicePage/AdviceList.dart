import 'package:flutter/material.dart';
import 'package:pet_care/pages/AdvicePage/AdviceWidget.dart';
import 'package:pet_care/pages/BasePage.dart';
import 'package:pet_care/repository/advicerepo.dart';

//Страница с полным списком статей
class AdviceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(body: AdviceGrid(), title: "Статьи");
  }
}

class AdviceGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 193,
            crossAxisSpacing: 2,
            mainAxisSpacing: 1,
          ),
          itemCount: articles.length,
          physics: ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => Container(
              child: AdviceBlock(
                  articles[index].title, articles[index].image, index))),
    );
  }
}

//Страница со списокм статей, которые находтся в избранном
class AdviceListFavourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(body: AdviceGridFavoirite(), title: "Избранное");
  }
}

class AdviceGridFavoirite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 193,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: 2,
          physics: ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => Container(
              child: AdviceBlock(
                  articles[index].title, articles[index].image, index))),
    );
  }
}
