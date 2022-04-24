import 'dart:ui';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/CalendarPage/repoMeetings.dart';

import '../NotesPage/controllers/reponotes.dart';

class Meeting {
  
  String eventName;
  String from;
  String to;
  bool isAllDay;
  int userId;
  String id;

  Meeting({this.eventName, this.from, this.to,this.isAllDay,this.userId,this.id});
  
  
  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
        eventName: json['EventName'],
        from: json['From'],
        to: json['To'],
        isAllDay: json['IsAllDay'],
        userId: json['UserID'],
        id: json['ID'],
        );

  }


  Map<String, dynamic> toJson()=>
  {
    'EventName':eventName,
    'From':from,
    'To':to,
    'IsAllDay':true,
    'UserID':userId,
    'ID':"0",
  };
}

abstract class MeetingResult{}

//указатель на успешный запрос
class MeetingResultSuccess extends MeetingResult {
  final List<Meeting> meetingsList;
  MeetingResultSuccess(this.meetingsList);
}

// произошла ошибка
class MeetingResultFailure extends MeetingResult {
  final String error;
  MeetingResultFailure(this.error);
}

// загрузка данных
class MeetingResultLoading extends MeetingResult {
  MeetingResultLoading();
}

class MeetingController extends ControllerMVC {
  // создаем наш репозиторий
  final RepositoryMeetings repo = new RepositoryMeetings();

  // конструктор нашего контроллера
  MeetingController();
  
  // первоначальное состояние - загрузка данных
  MeetingResult currentState = MeetingResultLoading();

  void init() async {
    try {
      // получаем данные из репозитория
      final meetingsList = await repo.getMeetings();
      // если все ок то обновляем состояние на успешное
      setState(() => currentState = MeetingResultSuccess(meetingsList));
    } catch (error) {
      // в противном случае произошла ошибка
      setState(() => currentState = MeetingResultFailure("Нет интернета"));
    }
  }

}