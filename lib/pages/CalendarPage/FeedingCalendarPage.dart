import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/CalendarPage/AlarmInfo.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../dommain/myuser.dart';
import '../BasePage.dart';
import '../Registration/ValidatorsReg.dart';
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
                _displayEventAdd(
                    context, _eventname, _datefrom, _dateto, update);

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
    title: Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text('Добавление события',
            style: Theme.of(context).copyWith().textTheme.headline2),
      ),
    ),
    actions: [
      ElevatedButton(
        child: Text('Добавить',
            style: Theme.of(context).copyWith().textTheme.bodyText1),
        onPressed: () {
          if (formKey1.currentState.validate() &&
              _dateto != null &&
              _datefrom != null) {
            addEvent(_eventname, _datefrom.toString(), _dateto.toString());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(2),
              ),
            );
            //Navigator.of(context).pop(true);
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
          child: Column(
            children: [
              AddInfo('Введите название события:'),
              TextFormField(
                maxLines: 3,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateText,
                onChanged: (value) {
                  _eventname = value;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите название и описание событие',
                  hintStyle: TextStyle(color: Color.fromARGB(153, 69, 69, 69)),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(43, 0, 0, 0),
                blurRadius: 5,
                offset: const Offset(0.0, 0.0),
                spreadRadius: 2.0,
              )
            ],
            color: Color.fromARGB(202, 242, 242, 242),
            border: Border.all(color: Color.fromARGB(202, 242, 242, 242)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
          //margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Column(
            children: [
              AddInfo('Введите дату события:'),
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
                      dateHintText: 'Дата события',
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
            ],
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(43, 0, 0, 0),
                blurRadius: 5,
                offset: const Offset(0.0, 0.0),
                spreadRadius: 2.0,
              )
            ],
            color: Color.fromARGB(202, 242, 242, 242),
            border: Border.all(color: Color.fromARGB(202, 242, 242, 242)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
          //margin: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Column(
            children: [
              AddInfo('Введите время события:'),
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
                            Theme.of(context).copyWith().textTheme.headline3,
                        highlightedTextStyle:
                            Theme.of(context).copyWith().textTheme.headline4,
                        spacing: 30,
                        itemHeight: 60,
                        isForce2Digits: true,
                        onTimeChange: (time) {
                          _dateto = time.toString();
                        },
                      ));
                },
              ),
            ],
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(43, 0, 0, 0),
                blurRadius: 5,
                offset: const Offset(0.0, 0.0),
                spreadRadius: 2.0,
              )
            ],
            color: Color.fromARGB(202, 242, 242, 242),
            border: Border.all(color: Color.fromARGB(202, 242, 242, 242)),
            borderRadius: BorderRadius.circular(10),
          ),
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
  for (var i in l) {
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
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
