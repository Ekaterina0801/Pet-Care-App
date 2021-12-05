import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//Страница для отображения календаря
class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      firstDayOfWeek: 1,
      todayHighlightColor: Color.fromRGBO(255, 223, 142, 1),
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
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
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
      scheduleViewMonthHeaderBuilder:
          (BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
        return Container(
            color: Colors.red,
            child: Text(
              details.date.month.toString() +
                  ' ,' +
                  details.date.year.toString(),
            ));
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
  meetings.add(Meeting('Забрать заказ с игрушкой', DateTime.utc(2021, 12, 21),
      DateTime.utc(2021, 12, 21), Color.fromRGBO(208, 76, 49, 100), false));

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
