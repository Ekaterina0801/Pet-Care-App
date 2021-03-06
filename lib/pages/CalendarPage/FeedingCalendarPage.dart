import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/CalendarPage/AlarmInfo.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../dommain/myuser.dart';
import '../BasePage.dart';
import '../Registration/util/shared_preference.dart';
import 'AddInfo.dart';
import 'Meeting.dart';
import 'Message.dart';
import 'repoMeetings.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

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

  }

  void update() {
    this.setState(() {});
  }

  String _eventname;
  String _datefrom, _dateto;
  MyUser user;
  List<Meeting> allmeetings = [];
  List<Meeting> meetings = [];
  GlobalKey<FormState> formKey1;
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
              meetings = snapshot.data;
        }

        return ListView(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade200,
              ),
              onPressed: () {
                _displayEventAdd(context, _eventname, _datefrom, _dateto,
                     update);
                
                /*
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DisplayAddInfo(
                        _eventname, _datefrom, _dateto, user.userid);
                  },
                );*/
              },
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text('+ Добавить событие',
                  style: Theme.of(context).textTheme.bodyText1),
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
                        MonthAppointmentDisplayMode.indicator,
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
                  dataSource: _getCalendarDataSource(meetings),
                  showDatePickerButton: true,
                ),
                height: 700),
          ],
        );
      },
    );
  }
}

_displayEventAdd(BuildContext context, String _eventname, String _datefrom,
    String _dateto, void update()) {
  final formKey1 = new GlobalKey<FormState>();
  AlertDialog alert = AlertDialog(
    title: Text('Добавление события'),
    actions: [
      ElevatedButton(
        child: Text(
          'Добавить',
          style: GoogleFonts.comfortaa(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w800,
              fontSize: 14),
        ),
        onPressed: () {
          if (formKey1.currentState.validate() &&
              _dateto != null &&
              _datefrom != null) {
            addEvent(_eventname, _datefrom.toString(), _dateto.toString());
            update();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(2),
              ),
            );
          } else
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Message();
              },
            );
        },
      ),
    ],
    content: Column(
      children: [
        AddInfo('Событие'),
        Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKey1,
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value.isEmpty ? "Поле пустое" : null,
              maxLines: 3,
              onChanged: (value) {
                _eventname = value;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Введите событие',
              ),
            ),
          ),
        ),
        AddInfo('Начало события'),
        Builder(
          builder: (context) {
            return Theme(
              data: ThemeData().copyWith(
                textTheme: Theme.of(context).textTheme,
                colorScheme: ColorScheme.light().copyWith(
                  primary: Color.fromRGBO(255, 223, 142, 1),
                  onPrimary: Colors.black,
                ),
              ),
              child: DateTimePicker(
                style: Theme.of(context).textTheme.bodyText1,
                initialValue: '',
                autovalidate: true,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Date',
                onChanged: (val) => _datefrom = val,
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => _datefrom = val,
              ),
            );
          },
        ),
        AddInfo('Окончание события'),
        Builder(
          builder: (context) {
            return Theme(
                data: ThemeData().copyWith(
                  textTheme: Theme.of(context).textTheme,
                  colorScheme: ColorScheme.light().copyWith(
                    primary: Color.fromRGBO(255, 223, 142, 1),
                    onPrimary: Colors.black,
                  ),
                ),
                child: TimePickerSpinner(
                  is24HourMode: false,
                  normalTextStyle:
                      TextStyle(fontSize: 24, color: Colors.deepOrange),
                  highlightedTextStyle:
                      TextStyle(fontSize: 24, color: Colors.yellow),
                  spacing: 50,
                  itemHeight: 80,
                  isForce2Digits: true,
                  onTimeChange: (time) {
                    _dateto = time.toString();
                  },
                ));
          },
        ),
      ],
    ),
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

_AppointmentDataSource _getCalendarDataSource(List<Meeting> l) {
  List<Appointment> appointments = <Appointment>[];
  for(var i in l)
  {
    appointments.add(Appointment(
    startTime: i.from,
    endTime: i.to,
    subject: i.textOfMention,
    color: Color.fromRGBO(255, 223, 142, 10),
    startTimeZone: '',
    endTimeZone: '',
  ));
  }

  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source){
   appointments = source; 
  }
}