import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//Страница для отображения календаря
class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

//Отображение календаря и кнопка добавления события
class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
                  )),
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
                    )
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
              dataSource: MeetingDataSource(_getDataSource()),
              showDatePickerButton: true,
            ),
            height: 700),
        FlatButton(
            height: 50,
            color: Colors.grey.shade100,
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) =>
                          AddEventWidget()));
            },
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text('+ Добавить событие',
                    style: GoogleFonts.comfortaa(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        fontSize: 14))))
      ],
    );
  }
}

//Диалоговое окно для добавления события
class AddEventWidget extends StatelessWidget {
  @override
  final DateTime today = DateTime.now();
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(alignment: Alignment.bottomCenter,
      child: Text('Добавить событие',
          style: GoogleFonts.comfortaa(
              color: Colors.black,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w800,
              fontSize: 16))),
      actions: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Text('Введите дату события:',
                style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 14))),
        DatePickerDialog(
          initialDate: today, 
          firstDate: DateTime.utc(2021, 12, 15), 
          lastDate: DateTime.utc(2022, 03, 11),
          helpText: 'Введите дату события:',),
        
      ],
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 1));
  meetings.add(
    Meeting('Покормить Гарри завтраком', startTime, endTime,
        Color.fromRGBO(255, 223, 142, 10), false),
  );
  meetings.add(
    Meeting(
        'Покормить Гарри ужином',
        DateTime(today.year, today.month, today.day, 19, 0, 0),
        DateTime(today.year, today.month, today.day, 21, 0, 0),
        Color.fromRGBO(255, 223, 142, 10),
        false),
  );
  meetings.add(Meeting(
      'Забрать интернет-заказ с новой игрушкой для Гарри',
      DateTime.utc(2021, 12, 21),
      DateTime.utc(2021, 12, 21),
      Color.fromRGBO(208, 76, 49, 100),
      false));

  meetings.add(Meeting(
      'Защита проекта',
      DateTime.utc(2021, 12, 14, 18, 0),
      DateTime.utc(2021, 12, 14, 21, 0),
      Color.fromRGBO(131, 184, 107, 60),
      false));
  meetings.add(Meeting('Дать таблетку', DateTime.utc(2021, 12, 15),
      DateTime.utc(2021, 12, 15), Color.fromRGBO(129, 181, 217, 10), false));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
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
