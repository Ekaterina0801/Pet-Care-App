// ignore: must_be_immutable
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BasePage.dart';
import '../Registration/ValidatorsReg.dart';
import 'AddInfo.dart';
import 'Meeting.dart';
import 'Message.dart';

class DisplayAddInfo extends StatefulWidget {
  String eventname, datefrom, dateto;
  int userID;

  DisplayAddInfo(this.eventname, this.datefrom, this.dateto, this.userID);

  @override
  State<DisplayAddInfo> createState() => _DisplayAddInfoState();
}

class _DisplayAddInfoState extends State<DisplayAddInfo> {
  GlobalKey<FormState> formKey1;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AlertDialog(
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
                    widget.dateto != null &&
                    widget.datefrom != null) {
                  addEvent(widget.eventname, widget.datefrom.toString(),
                      widget.dateto.toString());
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
                        widget.eventname = value;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Введите название и описание событие',
                        hintStyle:
                            TextStyle(color: Color.fromARGB(153, 69, 69, 69)),
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
                            onChanged: (val) => widget.datefrom = val,
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) => widget.datefrom = val,
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
                          child: DateTimePicker(
                            style: Theme.of(context).textTheme.bodyText1,
                            initialValue: '',
                            autovalidate: true,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Время события',
                            onChanged: (val) => widget.dateto = val,
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) => widget.dateto = val,
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
            ],
          ),
        ),
      ],
    );
  }
}
