import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../dommain/myuser.dart';
import '../Registration/util/shared_preference.dart';
import 'Meeting.dart';
import 'repoMeetings.dart';

//Страница для отображения календаря
class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

//Отображение календаря и кнопка добавления события
class _CalendarPageState extends StateMVC {
  MeetingController _controller;
  _CalendarPageState() : super(MeetingController()) {
    _controller = controller as MeetingController;
  }
  @override
  void initState() {
    super.initState();
    _controller.init();
    UserPreferences().getUser().then((result) {
      setState(() {
        user = result;
      });
    });
  }

  void update() {
    this.setState(() {});
  }

  final formKey = new GlobalKey<FormState>();
  String _eventname, _datefrom, _dateto;
  MyUser user;
  List<Meeting> allmeetings = [];
  List<Meeting> meetings = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RepositoryMeetings().getMeetings(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              allmeetings = snapshot.data;
        }
        for (var n in allmeetings) {
          if (n.userId == user.userid) meetings.add(n);
        }
        return ListView(
          children: [
            FlatButton(
              height: 50,
              color: Colors.grey.shade200,
              onPressed: () {
                _displayEventAdd(context, _eventname, _datefrom, _dateto,
                    user.userid, update);
              },
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '+ Добавить событие',
                  style: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
              ),
            ),
            Container(
                child: SfCalendar(
                  firstDayOfWeek: 1,
                  todayHighlightColor: Color.fromRGBO(208, 76, 49, 80),
                  todayTextStyle: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                  allowAppointmentResize: true,
                  blackoutDatesTextStyle: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 14),
                  appointmentTimeTextFormat: 'HH:mm',
                  appointmentTextStyle: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                  monthViewSettings: MonthViewSettings(
                    showAgenda: true,
                    agendaItemHeight: 70,
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                    agendaStyle: AgendaStyle(
                      dayTextStyle: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                      dateTextStyle: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                      appointmentTextStyle: GoogleFonts.comfortaa(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    ),
                  ),
                  scheduleViewMonthHeaderBuilder: (BuildContext buildContext,
                      ScheduleViewMonthHeaderDetails details) {
                    final String monthName = _getMonthName(details.date.month);
                    return Stack(
                      children: [
                        Image(
                            image: ExactAssetImage('assets/images/pets1.jpg'),
                            fit: BoxFit.cover,
                            width: details.bounds.width,
                            height: 180),
                        Positioned(
                          left: 55,
                          right: 0,
                          top: 20,
                          bottom: 0,
                          child: Text(
                            monthName + ' ' + details.date.year.toString(),
                            style: GoogleFonts.comfortaa(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w800,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    );
                  },
                  showNavigationArrow: true,
                  allowedViews: [
                    CalendarView.day,
                    CalendarView.month,
                    CalendarView.schedule
                  ],
                  view: CalendarView.month,
                  dataSource: MeetingDataSource(allmeetings),
                  showDatePickerButton: true,
                ),
                height: 700),
          ],
        );
      },
    );
  }
}

/*
//Диалоговое окно для добавления события
class AddEventWidget extends StatelessWidget {
  @override
  final DateTime today = DateTime.now();
  Widget build(BuildContext context) {
    return _displayEventAdd(context, _eventname, _datefrom, _dateto, userID, update())
    /*
    DatePickerDialog(
      initialDate: today,
      firstDate: DateTime.utc(1980, 01, 01),
      lastDate: DateTime.utc(2082, 01, 01),
      helpText: 'Введите дату события:',
    );*/
  }
}*/

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 1));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments[index].from);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(appointments[index].to);
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return Colors.red;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

String _getMonthName(int month) {
  if (month == 01) {
    return 'Январь';
  } else if (month == 02) {
    return 'Февраль';
  } else if (month == 03) {
    return 'Март';
  } else if (month == 04) {
    return 'Апрель';
  } else if (month == 05) {
    return 'Май';
  } else if (month == 06) {
    return 'Июнь';
  } else if (month == 07) {
    return 'Июль';
  } else if (month == 08) {
    return 'Август';
  } else if (month == 09) {
    return 'Сентябрь';
  } else if (month == 10) {
    return 'Октябрь';
  } else if (month == 11) {
    return 'Ноябрь';
  } else {
    return 'Декабрь';
  }
}

_displayEventAdd(BuildContext context, String _eventname, String _datefrom,
    String _dateto, int userID, void update()) {
  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey3 = new GlobalKey<FormState>();

  AlertDialog alert = AlertDialog(
    title: Text('Добавление события'),
    actions: [
      FlatButton(
        child: Text(
          'Добавить',
          style: GoogleFonts.comfortaa(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w800,
              fontSize: 14),
        ),
        onPressed: () {
          addEvent(_eventname, _datefrom, _dateto, userID);
          update();
          Navigator.of(context).pop(true);
        },
      ),
    ],
    content: Column(
        children: [
          addInfo('Событие'),
          Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey1,
              child: TextField(
                maxLines: 3,
                onChanged: (value) {
                  _eventname = value;
                  var now = DateTime.now();
                  //String formattedDate = DateFormat('dd-MM-yyyy  kk:mm').format(now);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите событие',
                  //hintStyle: TextStyle(color: Colors.white60),
                ),
              ),
            ),
          ),
          addInfo('начало'),
          Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey2,
              child: TextField(
                maxLines: 1,
                onChanged: (value) {
                  _datefrom = value;
                  var now = DateTime.now();
                  //String formattedDate = DateFormat('dd-MM-yyyy  kk:mm').format(now);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите событие',
                  //hintStyle: TextStyle(color: Colors.white60),
                ),
              ),
            ),
          ),
          addInfo('Дата окончания'),
          Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey3,
              child: TextField(
                maxLines: 1,
                onChanged: (value) {
                  _dateto = value;
                  var now = DateTime.now();
                  //String formattedDate = DateFormat('dd-MM-yyyy  kk:mm').format(now);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите дату окончания события',
                  //hintStyle: TextStyle(color: Colors.white60),
                ),
              ),
            ),
          ),
        ],
      
    ),
/*
    Container(
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(251, 236, 192, 10),
            ),
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: TextField(
                maxLines: 10,
                onChanged: (value) {
                  _eventname = value;
                  var now = DateTime.now();
                  //String formattedDate = DateFormat('dd-MM-yyyy  kk:mm').format(now);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите событие',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ),
            ),
          ),
/*
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(251, 236, 192, 10),
            ),
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: TextField(
                maxLines: 10,
                onChanged: (value) {
                  _datefrom = value;
                  //var now = DateTime.now();
                  //String formattedDate = DateFormat('dd-MM-yyyy  kk:mm').format(now);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите дату начала события',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ),
            ),
          ),*/
          /*
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(251, 236, 192, 10),
            ),
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: TextField(
                maxLines: 10,
                onChanged: (value) {
                  _dateto = value;
                  var now = DateTime.now();
                  //String formattedDate = DateFormat('dd-MM-yyyy  kk:mm').format(now);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите дату окончания события',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ),
            ),
          ),*/
        ],
      ),
    */
  );
  Future.delayed(
    Duration.zero,
    () async {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    },
  );
}

Future<Map<String, dynamic>> addEvent(
    String text, String datefrom, String dateto, int userID) async {
  final Map<String, dynamic> noteData = {
    'EventName': text,
    'IsAllDay':true,
    'From': datefrom,
    'To': dateto,
    'Id': 1,
    'UserID': userID
  };
  var response = await post(
      Uri.parse(
          'https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Meetings.json'),
      body: json.encode(noteData));
  Meeting m =
    Meeting(eventName: noteData['EventName'], id: noteData['Id'], from: noteData['From'],to:noteData['To'],isAllDay: noteData['IsAllDay'],userId: noteData['UserID']);
  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': m};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
}

Widget addInfo(String text)
{
  return Align(
            alignment: Alignment.bottomLeft,
            child: Text(text,
                style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 14)));
}