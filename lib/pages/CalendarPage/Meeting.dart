import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/CalendarPage/repoMeetings.dart';

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

Future<Map<String, dynamic>> addEvent(
    String text, String datefrom, String dateto, int userID) async {
  final Map<String, dynamic> noteData = {
    'EventName': text,
    'IsAllDay': true,
    'From': datefrom,
    'To': dateto,
    'Id': "1",
    'UserID': userID
  };
  var response = await post(
      Uri.parse(
          'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Meetings.json'),
      body: json.encode(noteData));
  Meeting m = Meeting(
      eventName: noteData['EventName'],
      id: noteData['Id'],
      from: noteData['From'],
      to: noteData['To'],
      isAllDay: noteData['IsAllDay'],
      userId: noteData['UserID']);
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': m};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
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