import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/NotesPage/Note.dart';
import 'package:pet_care/pages/NotesPage/reponotes.dart';

class NoteController extends ControllerMVC {
  // создаем наш репозиторий
  final RepositoryNotes repo = new RepositoryNotes();

  // конструктор нашего контроллера
  NoteController();
  
  // первоначальное состояние - загрузка данных
  NoteResult currentState = NoteResultLoading();

  void init() async {
    try {
      // получаем данные из репозитория
      final notesList = await repo.getNotes();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = NoteResultSuccess(notesList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = NoteResultFailure("Нет интернета"));
    }
  }

}