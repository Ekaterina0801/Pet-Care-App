import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'Meeting.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments[index].date);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(appointments[index].time);
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return Color.fromRGBO(255, 223, 142, 10);
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

