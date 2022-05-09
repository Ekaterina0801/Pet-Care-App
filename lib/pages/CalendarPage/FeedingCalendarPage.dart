import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../dommain/myuser.dart';
import '../BasePage.dart';
import '../Registration/util/shared_preference.dart';
import 'AddInfo.dart';
import 'DisplayAddInfo.dart';
import 'Meeting.dart';
import 'MeetingDataSource.dart';
import 'Message.dart';
import 'repoMeetings.dart';
import 'package:date_time_picker/date_time_picker.dart';

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
    UserPreferences().getUser().then(
      (result) {
        setState(
          () {
            user = result;
          },
        );
      },
    );
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
              allmeetings = snapshot.data;
        }
        for (var n in allmeetings) {
          if (n.userId == user.userid) meetings.add(n);
        }
        return ListView(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade200,
              ),
              onPressed: () {
                _displayEventAdd(context, _eventname, _datefrom, _dateto, user.userid, update);
                 
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
_displayEventAdd(BuildContext context, String _eventname, String _datefrom,
      String _dateto, int userID, void update()) {
    final formKey1 = new GlobalKey<FormState>();
    var formKey;
    AlertDialog alert = AlertDialog(
      title: Container(
      child: Align(
      alignment: Alignment.bottomCenter,
      child: Text('Добавление события',
      style: Theme.of(context).copyWith().textTheme.bodyText2),),),
      actions: [
        Container(
          height: 33,
          child: ElevatedButton( 
            child: Text('Добавить',
              style: Theme.of(context).copyWith().textTheme.bodyText1),
            onPressed: () {
              if (formKey1.currentState.validate() &&
                  _dateto != null &&
                  _datefrom != null)
                  {
                addEvent(
                    _eventname, _datefrom.toString(), _dateto.toString(), userID);
              update();
              Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => HomePage(2),
                          ),
                        );
                  }
                  else showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Message();
                  },
                );
            },
          ),
        ),
      ],
      
      content: Container(
        margin: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
        child: Column(
          children: [
            Form(
              key: formKey,
                child: Column(
                  children: [
                  //AddInfo('Событие'),
                    Container(
             padding: EdgeInsets.symmetric(horizontal: 7, vertical: 12),
             child: Column(
             children: [
              Container(
                child: Align(
                alignment:Alignment.bottomLeft,
                child: Text('Введите событие:',
                style: Theme.of(context).copyWith().textTheme.bodyText1),
                ),
              ),
                TextFormField(
                maxLines: 3,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => 
                  value.isEmpty 
                    ? "Поле пустое" 
                    : null,
                onChanged: (value) {
                  _eventname = value;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Введите событие',
                  hintStyle: TextStyle(
                  color: Color.fromARGB(153, 69, 69, 69)),
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
                spreadRadius: 2.0)],  
                color: Color.fromARGB(202, 242, 242, 242),
                border: Border.all(color:Color.fromARGB(202, 242, 242, 242)),
                borderRadius: BorderRadius.circular(10),
                ),
              ),

          SizedBox(height: 15),

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

            SizedBox(height: 15),

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
                child: DateTimePicker(
                  style: Theme.of(context).textTheme.bodyText1,
                  initialValue: '',
                  autovalidate: true,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date',
                  onChanged: (val) => _dateto = val,
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => _dateto = val,
                ),
              );
            },
          ),
        ],
       ),),
      ]))
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

