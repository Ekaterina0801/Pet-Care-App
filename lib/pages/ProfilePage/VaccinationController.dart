import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/ProfilePage/vaccinationsrepo.dart';

import 'Vaccination.dart';

class VaccinationController extends ControllerMVC {
  // создаем наш репозиторий
  final RepositoryVaccinations repo = new RepositoryVaccinations();

  // конструктор нашего контроллера
  VaccinationController();

  // первоначальное состояние - загрузка данных
  VaccinationResult currentState = VaccinationResultLoading();

  void init() async {
    try {
      // получаем данные из репозитория
      final vaccList = await repo.getvacc();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = VaccinationResultSuccess(vaccList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = VaccinationResultFailure("Нет интернета"));
    }
  }
}

abstract class VaccinationResult {}

//указатель на успешный запрос
class VaccinationResultSuccess extends VaccinationResult {
  final List<Vaccination> vaccList;
  VaccinationResultSuccess(this.vaccList);
}

// произошла ошибка
class VaccinationResultFailure extends VaccinationResult {
  final String error;
  VaccinationResultFailure(this.error);
}

// загрузка данных
class VaccinationResultLoading extends VaccinationResult {
  VaccinationResultLoading();
}