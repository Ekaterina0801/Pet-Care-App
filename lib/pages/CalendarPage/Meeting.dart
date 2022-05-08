import 'dart:convert';

import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/CalendarPage/repoMeetings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Meeting {
  int mentionId;
  String textOfMention;
  String date;
  String time;

  Meeting({this.mentionId, this.textOfMention, this.date, this.time});

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
        mentionId: json['mentionId'],
        textOfMention: json['textOfMention'],
        date: json['date'].toString().substring(0, 10),
        time: json['time']);
  }

  Map<String, dynamic> toJson() => {
        'mentionId': mentionId,
        'textOfMention': textOfMention,
        'date': date,
        'time': time
      };

  Map<String, dynamic> toMap() {
    return ({
      'mentionId': mentionId,
      'textOfMention': textOfMention,
      'date': date,
      'time': time
    });
  }
}

Future<Map<String, dynamic>> addEvent(
    String text, String date, String time) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.get('userId');
  final Map<String, dynamic> noteData = {
    'user_id': userId,
    'text': text,
    'date': date,
    'time': time.substring(11,19),
  };
  var response = await post(
    Uri.parse(
        'http://vadimivanov-001-site1.itempurl.com/Register/RegisterMention'),
    body: json.encode(noteData),
    headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
  );
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': noteData};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
}

abstract class MeetingResult {}

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
