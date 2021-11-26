import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

class CalendarPage extends StatefulWidget {
  //const CalendarPage({ Key? key }) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      firstDayOfWeek: 1,
      todayHighlightColor: Colors.orange,
      blackoutDatesTextStyle: GoogleFonts.comfortaa(
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w800,
          fontSize: 14),
      appointmentTextStyle: GoogleFonts.comfortaa(
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w800,
          fontSize: 14),
      monthViewSettings: MonthViewSettings(showAgenda: true),
      // monthCellBuilder:
      //     (BuildContext buildContext, MonthCellDetails details) {
      //   return Container(
      //     color: Colors.red,
      //     child: Text(
      //       details.date.day.toString(),
      //     ),
      //   );
      // },
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
        CalendarView.week,
        CalendarView.month,
        CalendarView.schedule
      ],
      view: CalendarView.month,
      dataSource: MeetingDataSource(_getDataSource()),
      showDatePickerButton: true,
      selectionDecoration: BoxDecoration(),
    );
    /*
        FloatingActionButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Container())))
                */
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(
    Meeting(
        'Купить таблетку для Гарри', startTime, endTime, Colors.orange, false),
  );

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
/*
class FeedingCalendarPage extends StatefulWidget {
  const FeedingCalendarPage({Key key}) : super(key: key);

  @override
  State<FeedingCalendarPage> createState() => _FeedingCalendarPageState();
}

class _FeedingCalendarPageState extends State<FeedingCalendarPage> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: focusedDay,
          onDaySelected: (DateTime selectDay, DateTime focusDay) {
            setState(() {
              selectedDay = selectedDay;
              focusedDay = focusedDay;
            });
            print(focusDay);
          },
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration:
                BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          ),
         // eventLoader: (day) {
            //return _getEventsForDay(day);
         // },
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          calendarFormat: format,
          onFormatChanged: (CalendarFormat _format) {
            setState(() {
              format = _format;
            });
          },
        )
      ],
    );
  }
}
/*
List<Event> _getEventsForDay(DateTime day) {
  return events[day] ?? [];
}

final events = LinkedHashMap[
  
];
*/
/*
final events = LinkedHashMap(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(eventSource);
*/
*/