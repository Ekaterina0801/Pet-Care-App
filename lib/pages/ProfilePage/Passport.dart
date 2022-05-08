import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/welcomescreen.dart';
import 'DiseasePage.dart';
import 'VaccinationPage.dart';


            /*decoration: BoxDecoration(  
              color: Color.fromARGB(202, 242, 242, 242),
              border: Border.all(color:Color.fromARGB(202, 242, 242, 242)),
              borderRadius: BorderRadius.circular(10),
            ),*/

              /*decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(43, 0, 0, 0),
                    blurRadius: 5,
                    offset: const Offset(0.0, 0.0),
                    spreadRadius: 2.0)],  
                  color: Color.fromARGB(202, 242, 242, 242),
                  border: Border.all(color:Color.fromARGB(202, 242, 242, 242)),
                  borderRadius: BorderRadius.circular(10)),*/

//ignore: must_be_immutable
class Passport extends StatelessWidget {
  String nameowner;
  String dateb;
  String breed;
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
        InfoWidget("Дата рождения питомца:", dateb),
        Padding(
          padding: EdgeInsets.all(7),
          child: Container(
            height: 50,
            width: 400,
            child: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              //color: Color.fromRGBO(255, 223, 142, 10),
              // splashColor: Color.fromRGBO(240, 240, 240, 10),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DiseasePage())),
              child: Text( 'Болезни',
                style: Theme.of(context).copyWith().textTheme.bodyText2),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(7),
          child: Container(
            height: 50,
            width: 400,
            child: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style,
              //color: Color.fromRGBO(255, 223, 142, 10),
              // splashColor: Color.fromRGBO(240, 240, 240, 10),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VaccinationPage())),
              child: Text('Прививки',
                style: Theme.of(context).copyWith().textTheme.bodyText2), 
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(7),
          child: Container(
            height: 50,
            width: 400,
            child: ElevatedButton(
              //color: Color.fromRGBO(255, 223, 142, 10),
              //splashColor: Color.fromRGBO(240, 240, 240, 10),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                );
              },
              child: Text('Выйти из профиля',
                textAlign: TextAlign.left,
                style: Theme.of(context).copyWith().textTheme.bodyText2),
            ),
          ),
        ),
      ],
    );
  }
}

//ignore: must_be_immutable
class InfoWidget extends StatelessWidget {
  final String title;
  String info;
  InfoWidget(this.title, this.info);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Card(
            color: Color.fromRGBO(240, 240, 240, 1),
            shadowColor: Colors.grey, 
              child: ListTile(
                title: Text(title, 
                  style: Theme.of(context).copyWith().textTheme.bodyText2),
                subtitle: Text(info, 
                  style: Theme.of(context).copyWith().textTheme.bodyText1),
                isThreeLine: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Функция, выбирающая нужное диалоговое окно
//ignore: must_be_immutable
class ChooseRemakeWidget extends StatelessWidget {
  final String title;
  String info;
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
//ignore: must_be_immutable
class RemakeNameWidget extends StatelessWidget {
  final String title;
  String info;
  RemakeNameWidget(this.title, this.info);

  var name = "";
  var surname = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Изменение имени владельца',
              style: Theme.of(context).copyWith().textTheme.bodyText1),
      ),
      actions: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Text('Введите имя:',
                style: Theme.of(context).copyWith().textTheme.bodyText1),
          ),
        TextFormField(
          autofocus: false,
          onSaved: (value) => name = value,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Align(
            alignment: Alignment.bottomLeft,
            child: Text('Введите фамилию:',
                style: Theme.of(context).copyWith().textTheme.bodyText1),
        ),
        TextFormField(
          autofocus: false,
          onSaved: (value) => surname = value,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
//        longButtons(
//          "Принять", doRename(info,name, surname)
//       )
        ElevatedButton(
            // color: Color.fromRGBO(255, 223, 142, 10),
            //splashColor: Color.fromARGB(199, 240, 240, 240),
            onPressed: () =>
                {doRename(info, name, surname), (Navigator.pop(context, true))},
            child: Text('Принять',
                textAlign: TextAlign.left,
                style: Theme.of(context).copyWith().textTheme.bodyText1),
        )
      ],
    );
  }
}

var doRename = (info, name, surname) {
  info = name + " " + surname;
};

//Диалоговое окно для изменения породы питомца
//ignore: must_be_immutable
class RemakeBreedWidget extends StatefulWidget {
  final String title;
  String info;
  RemakeBreedWidget(this.title, this.info);

  @override
  State<RemakeBreedWidget> createState() => _RemakeBreedWidgetState();
}

class _RemakeBreedWidgetState extends State<RemakeBreedWidget> {
  @override
  _changeBreed(String value) {
    setState(() => widget.info = value);
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Изменение породы питомца',
              style: Theme.of(context).copyWith().textTheme.bodyText1),),
      actions: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Text('Введите породу:',
                style: Theme.of(context).copyWith().textTheme.bodyText1),),
        TextFormField(
          autofocus: false,
          onChanged: _changeBreed,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
//        longButtons(
//          "Принять",
//       )
        ElevatedButton(
            //color: Color.fromRGBO(255, 223, 142, 10),
            //splashColor: Color.fromARGB(199, 240, 240, 240),
            style: Theme.of(context).elevatedButtonTheme.style,
            onPressed: () => (Navigator.pop(context, true)),
            child: Text('Принять',
                textAlign: TextAlign.left,
                style: Theme.of(context).copyWith().textTheme.bodyText1),),
      ],
    );
  }
}

//Диалоговое окно для изменения даты рождения питомца
//ignore: must_be_immutable
class RemakeDateBirthWidget extends StatelessWidget {
  final String title;
  String info;
  RemakeDateBirthWidget(this.title, this.info);
  @override
  final DateTime today = DateTime.now();
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Изменение даты рождения питомца',
              style: Theme.of(context).copyWith().textTheme.bodyText1),),
      actions: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Text('Введите дату рождения:',
                style: Theme.of(context).copyWith().textTheme.bodyText1),),
        TextFormField(autofocus: false, onSaved: (value) => info = value),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
//        longButtons(
//          "Принять",
//       )
        ElevatedButton(
            // color: Color.fromRGBO(255, 223, 142, 10),
            //splashColor: Color.fromARGB(199, 240, 240, 240),
            onPressed: () => (Navigator.pop(context, true)),
            child: Text('Принять',
                textAlign: TextAlign.left,
                style: Theme.of(context).copyWith().textTheme.bodyText1),),
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
