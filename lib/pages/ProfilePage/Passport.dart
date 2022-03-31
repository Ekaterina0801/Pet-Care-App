import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/ProfilePage/Vaccinations.dart';

import 'Disease.dart';

class Passport extends StatelessWidget {
  final String nameowner;
  final String dateb;
  final String breed;
  final String color;
  final String vac;
  final String ill;
  Passport(
      this.nameowner, this.dateb, this.breed, this.color, this.vac, this.ill);

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InfoWidget("Владелец:", nameowner),
        InfoWidget("Порода:", breed),
        InfoWidget("Дата рождения питомца: ", dateb),
        Padding(
            padding: EdgeInsets.all(7),
            child: Container(
                height: 55,
                width: 400,
                child: RaisedButton(
                    color: Color.fromRGBO(255, 223, 142, 10),
                    splashColor: Color.fromRGBO(240, 240, 240, 10),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VaccinationsPage())),
                    child: Text('Прививки',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.comfortaa(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800,
                            fontSize: 17))))),
        Padding(
            padding: EdgeInsets.all(7),
            child: Container(
                height: 55,
                width: 400,
                child: RaisedButton(
                    color: Color.fromRGBO(255, 223, 142, 10),
                    splashColor: Color.fromRGBO(240, 240, 240, 10),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DiseasePage())),
                    child: Text('Болезни',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.comfortaa(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800,
                            fontSize: 17))))),
      ],
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String title;
  final String info;
  InfoWidget(this.title, this.info);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(children: [
        Expanded(
          child: Card(
              color: Color.fromRGBO(240, 240, 240, 1),
              shadowColor: Colors.grey,
              child: ListTile(
                title: Text(
                  title,
                  style: GoogleFonts.comfortaa(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w900,
                      fontSize: 17),
                ),
                subtitle: Text(
                  info,
                  style: GoogleFonts.comfortaa(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 15),
                ),
                leading: FlatButton(
                  child: Icon(Icons.edit),
                  color: Colors.grey.shade100,
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                ChooseRemakeWidget(title, info)));
                  },
                ),
                isThreeLine: true,
              )),
        )
      ]),
    );
  }
}

//Функция, выбирающая нужное диалоговое окно
class ChooseRemakeWidget extends StatelessWidget {
  final String title;
  final String info;
  ChooseRemakeWidget(this.title, this.info);
  @override
  Widget build(BuildContext context) {
    if (title == "Владелец:")
      return RemakeNameWidget(title, info);
    else if (title == "Порода:")
      return RemakeBreedWidget(title, info);
    else
      return RemakeDateBirthWidget(title, info);
  }
}

//Диалоговое окно для изменения имени владельца
class RemakeNameWidget extends StatelessWidget {
  final String title;
  final String info;
  RemakeNameWidget(this.title, this.info);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Изменение имени владельца',
              style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 16))),
      actions: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Text('Введите имя:',
                style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 14))),
        Align(
            alignment: Alignment.bottomLeft,
            child: Text('Введите фамилию:',
                style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 14)))
      ],
    );
  }
}

//Диалоговое окно для изменения породы питомца
class RemakeBreedWidget extends StatelessWidget {
  final String title;
  final String info;
  RemakeBreedWidget(this.title, this.info);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Изменение породы питомца',
              style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 16))),
      actions: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Text('Введите породу:',
                style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 14))),
      ],
    );
  }
}

//Диалоговое окно для изменения даты рождения питомца
class RemakeDateBirthWidget extends StatelessWidget {
  final String title;
  final String info;
  RemakeDateBirthWidget(this.title, this.info);
  @override
  final DateTime today = DateTime.now();
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Изминение даты рождения питомца',
              style: GoogleFonts.comfortaa(
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 16))),
      actions: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Text('Введите дату рождения:',
                style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    fontSize: 14))),
        DatePickerDialog(
          initialDate: today,
          firstDate: DateTime.utc(1980, 01, 01),
          lastDate: DateTime.utc(2082, 01, 01),
          helpText: 'Введите дату рождения:',
        ),
      ],
    );
  }
}
 /*FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        elevation: 1,
        onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VaccinationsPage())),
        label: Text('Прививки',
        textAlign: TextAlign.left,
                      style: GoogleFonts.comfortaa(
                        fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)
                    )
      ),
        TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VaccinationsPage())),
            child: const Text('Прививки'),
          ),*/
        //InfoWidget("Прививки:", vac),
        //InfoWidget("Болезни: ", ill),


         /*  Card(
          
          child: Row(
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20,color: Colors.black),
                  ),
                  onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DiseasePage())),
                  child: const Text('Болезни',style:TextStyle(color: Colors.black)),
                ),
            ],
          ),
        ),*/
