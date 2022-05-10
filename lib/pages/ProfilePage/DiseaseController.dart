import 'package:mvc_pattern/mvc_pattern.dart';

import 'Disease.dart';
import 'diseaserepo.dart';

class DiseaseController extends ControllerMVC {
  // создаем наш репозиторий
  final RepositoryDiseases repo = new RepositoryDiseases();

  // конструктор нашего контроллера
  DiseaseController();

  // первоначальное состояние - загрузка данных
  DiseaseResult currentState = DiseaseResultLoading();

  void init() async {
    try {
      // получаем данные из репозитория
      final diseasesList = await repo.getdiseases();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = DiseaseResultSuccess(diseasesList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = DiseaseResultFailure("Нет интернета"));
    }
  }
}

abstract class DiseaseResult {}

//указатель на успешный запрос
class DiseaseResultSuccess extends DiseaseResult {
  final List<Disease> diseasesList;
  DiseaseResultSuccess(this.diseasesList);
}

// произошла ошибка
class DiseaseResultFailure extends DiseaseResult {
  final String error;
  DiseaseResultFailure(this.error);
}

// загрузка данных
class DiseaseResultLoading extends DiseaseResult {
  DiseaseResultLoading();
}