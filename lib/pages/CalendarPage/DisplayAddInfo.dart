// ignore: must_be_immutable
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BasePage.dart';
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
    return AlertDialog(
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
                widget.dateto != null &&
                widget.datefrom != null) {
              addEvent(widget.eventname, widget.datefrom.toString(),
                  widget.dateto.toString(), widget.userID);
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
                  widget.eventname = value;
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
    );
  }
}
