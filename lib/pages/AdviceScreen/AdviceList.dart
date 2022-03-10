import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/BasePage.dart';
import 'package:pet_care/repository/advicerepo.dart';

import 'AdviceWidget.dart';
import 'requests/controllers/ArticleController.dart';
import 'requests/models/ArticleJ.dart';

/*
//Страница с полным списком статей
class AdviceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(body: AdviceGrid(), title: "Статьи");
  }
}

class AdviceGrid extends StatefulWidget {
  @override
  State<AdviceGrid> createState() => _AdviceGridState();
}

class _AdviceGridState extends State<AdviceGrid> {
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
*/

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}


class _ArticleListPageState extends StateMVC {

  // ссылка на контроллер
  ArticleController _controller;

  // передаем наш контроллер StateMVC конструктору и
  // получаем на него ссылку
  _ArticleListPageState() : super(ArticleController()) {
    _controller = controller as ArticleController;
  }

  // после инициализации состояния
  // мы запрашивает данные у сервера
  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: _buildContent(),
      title: "Статьи",
    );
  }

  Widget _buildContent() {
    // первым делом получаем текущее состояние
    final state = _controller.currentState;
    if (state is ArticleResultLoading) {
      // загрузка
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is ArticleResultFailure) {
      // ошибка
      return Center(
        child: Text(
          state.error,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.red)
        ),
      );
    } else {
      // отображаем список постов
      final articles = (state as ArticleResultSuccess).articleList.articles;
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
                  articles[index].title, articless[index].image, index))),
    );
    }
  }
}