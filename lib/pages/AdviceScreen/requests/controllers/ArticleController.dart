import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/AdviceScreen/requests/data/repoarticles.dart';
import 'package:pet_care/pages/AdviceScreen/requests/models/Article.dart';


class ArticleController extends ControllerMVC {
  // создаем наш репозиторий
  final Repository repo = new Repository();

  // конструктор нашего контроллера
  ArticleController();
  
  // первоначальное состояние - загрузка данных
  ArticleResult currentState = ArticleResultLoading();

  void init() async {
    try {
      // получаем данные из репозитория
      final articleList = await repo.getArticles();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = ArticleResultSuccess(articleList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = ArticleResultFailure("Нет интернета"));
    }
  }

}
