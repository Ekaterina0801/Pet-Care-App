import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_care/pages/AdvicePage/AdviceWidget.dart';
import 'package:pet_care/pages/AdvicePage/Article.dart';
import 'package:pet_care/pages/BasePage.dart';
import 'package:pet_care/pages/NotesPage/Note.dart';
import 'package:pet_care/repository/advicerepo.dart';
import 'package:pet_care/repository/notesrepo.dart';

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
      padding: EdgeInsets.all(10),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 220,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: articles.length,
          physics: ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => Container(
              child: AdviceBlock(
                  articles[index].title, articles[index].image, 0))),
    );
  }
}
