import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:pet_care/pages/PetBoardingPage/Overexposure.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CalendarPage/Message.dart';
import '../ProfilePage/ProfilePage.dart';
import '../Registration/util/widgets.dart';
import 'AccountBlock.dart';

//Страница для настроек аккаунта для сервиса передержки
class SettingsService extends StatefulWidget {
  final String email;
  final String district;
  final String kindofanimal;
  final String price;
  SettingsService({this.email, this.district, this.kindofanimal, this.price});

  @override
  State<SettingsService> createState() => _SettingsServiceState();
}

class _SettingsServiceState extends State<SettingsService> {
  String district = "Советский";
  String price = "1000";
  String contacts = "ekaterina_dots@mail.ru";
  _changeDistrict(String text) {
    setState(() => district = text);
  }

  _changePrice(String text) {
    setState(() => price = text);
  }

  _changeContacts(String text) {
    setState(() => contacts = text);
  }

  void update() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Overexposure> overexposures = [];
    return Scaffold(
      appBar: AppBar(
        actions: [],
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 223, 142, 10),
        title: Text("Настройки",
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 20)),
      ),
      body: FutureBuilder(
        future: getMyOverexposures(),
        builder: (context, snapshot) {
          overexposures = snapshot.data;
          bool flag = overexposures == null;
          return ListView(
            children: [
              //MyAccountWidget(accounts[0]),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(242, 242, 242, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: const Offset(1.0, 1.0),
                        spreadRadius: 0.0,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Контакты: $contacts ",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.comfortaa(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                              fontSize: 14)),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, size: 16),
                      onPressed: () => _displayDialogContacts(context),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                //margin: EdgeInsets.only(top: 5, bottom: 5),
                decoration:
                    BoxDecoration(color: Color.fromRGBO(242, 242, 242, 1),
                        //borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: const Offset(1.0, 1.0),
                        spreadRadius: 0.0,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Район: $district ",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.comfortaa(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w800,
                              fontSize: 14)),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, size: 16),
                      onPressed: () => _displayDialogContacts(context),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(242, 242, 242, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: const Offset(1.0, 1.0),
                        spreadRadius: 0.0,
                      )
                    ]),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text("Кого готовы брать на передержку?",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.comfortaa(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14)),
                          ),
                        ]),
                    SetKindPets(),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                
                  child: Text('Добавить передержку', style: Theme.of(context).textTheme.bodyText1,),
                  onPressed: () => _displayAddOverexposure(context, update),
                ),
              ),
              Center(
                child: Container(
                  child: Text('Мои передержки'),
                ),
              ),
              flag
                  ? Container()
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 255,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: overexposures.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        child: AccountBlock(overexposures[index], index),
                      ),
                    ),
            ],
          );
        },
      ),
    );
    
  }
  _displayDialogPrice(BuildContext context) {
    AlertDialog alert = AlertDialog(
        title: Text('Редактировать стоимость'),
        actions: [
          ElevatedButton(
            child: Text(
              'Принять',
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
        content: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            initialValue: price,
            maxLength: 12,
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 16),
            onChanged: _changePrice,
            validator: (price) {
              if (isPriceValid(price))
                return null;
              else
                return 'Введите корректную стоимость';
            },
          ),
        ));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  _displayDialogContacts(BuildContext context) {
    AlertDialog alert = AlertDialog(
        title: Text('Редактировать контакты'),
        actions: [
          ElevatedButton(
            child: Text(
              'Принять',
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
        content: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            maxLength: 26,
            initialValue: contacts,
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 16),
            onChanged: _changeContacts,
          ),
        ));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  bool isDistrictValid(String district) {
    RegExp regex = new RegExp(r'[А-ЯЁ][а-яё]*$');
    return regex.hasMatch(district);
  }

  bool isPriceValid(String price) {
    RegExp regex = new RegExp(r'[0-9]*$');
    return regex.hasMatch(price);
  }
  _displayAddOverexposure(BuildContext context, void update()) {
    final formKey1 = new GlobalKey<FormState>();
    final formKey2 = new GlobalKey<FormState>();
    final formKey3 = new GlobalKey<FormState>();
    String animal;
    String oNote;
    String cost;
    AlertDialog alert = AlertDialog(
      title: Align(
        alignment: Alignment.bottomCenter,
        child: Text('Добавление передержки',
          style: Theme.of(context).copyWith().textTheme.bodyText1),
      ),
      actions: [
        Column(
          children: [
            Form(
              key: formKey1,
              child: Column(
                children: [
                  addInfo('Выберите тип питомца'),
                  SelectFormField(
      autofocus: false,
      items: [
        {'value': 'Кот/кошка', 'label': 'Кот/кошка'},
        {'value': 'Собака', 'label': 'Собака'},
        {'value': 'Черепаха', 'label': 'Черепаха'},
        {'value': 'Рыба', 'label': 'Рыба'},
        {'value': 'Попугай', 'label': 'Попугай'},
      ],
      validator: (value) => value.isEmpty ? "Поле пустое" : null,
      onChanged: (value) => animal = value,
      onSaved: (value) => animal = value,
      decoration: buildInputDecoration("Вид питомца", Icons.pets),
    ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ],
              ),
            ),
            Form(
              key: formKey2,
              child: Column(
                children: [
                  addInfo('Введите стоимость передержки'),
                  TextFormField(
                    validator: validateDigits,
                    autofocus: false,
                    onChanged: (value) => cost = value,
                  ),
                ],
              ),
            ),
            Form(
              key: formKey3,
              child: Column(
                children: [
                  addInfo('Ваши пожелания или примечания:'),
                  TextFormField(
                    maxLines: 4,
                    validator: (value) => value.isEmpty ? "Поле пустое" : null,
                    autofocus: false,
                    onChanged: (value) => oNote = value,
                  ),
                ],
              ),
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 25)),

            Container(
              height: 33,
              child: ElevatedButton(
                onPressed: () 
                //formKey1.currentState.validate()&&formKey2.currentState.validate()&&formKey3.currentState.validate()?
                {
                  formKey1.currentState.validate()&&formKey2.currentState.validate()&&formKey3.currentState.validate()?
                  addOverexposure(animal,cost,oNote):
                  showDialog(
              context: context,
              builder: (BuildContext context) {
                return Message();
              },
            );
                  update();
                  Navigator.pop(context, true);
                  update();
                },
                child: Text('Добавить',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).copyWith().textTheme.bodyText1),
              ),
            ),
          ],
        ),
      ],
    );

    Future.delayed(
      Duration.zero,
      () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ListView(
              children: [
                alert,
              ],
            );
          },
        );
      },
    );
  }

}

Future<Map<String, dynamic>> addOverexposure(String animal, String cost, String oNote) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.get('userId');
  final Map<String, dynamic> data = {
    'user_id': userId,
    'animal': animal,
    'cost':cost,
    'overexposure_note': oNote,
  };
  var response = await post(
    Uri.parse(
        'http://vadimivanov-001-site1.itempurl.com/Register/RegisterOverexposure'),
    body: json.encode(data),
    headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
  );

  var result;
  if (response.request != null)
    result = {'status': true, 'message': 'Successfully add', 'data': data};
  else {
    result = {'status': false, 'message': 'Adding failed', 'data': null};
  }
  return result;
}
String validateDigits(String value) {
  String _msg;
  RegExp regex = new RegExp(
      r'^(\d+)$');
  if (value.isEmpty) {
    _msg = "Введите число";
  } else if (!regex.hasMatch(value)) 
   _msg = "Можно ввести только целое число";
  return _msg;
}

  


class SetKindPets extends StatefulWidget {
  @override
  _SetKindPetsState createState() => _SetKindPetsState();
}

class _SetKindPetsState extends State<SetKindPets> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(children: [
        Checkbox(
            checkColor: Colors.black,
            value: isChecked1,
            onChanged: (value) {
              setState(() {
                isChecked1 = value;
              });
            }),
        Container(
          padding: EdgeInsets.all(5),
          child: Text("Собаки",
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14)),
        ),
        Checkbox(
            checkColor: Colors.black,
            value: isChecked2,
            onChanged: (value) {
              setState(() {
                isChecked2 = value;
              });
            }),
        Container(
          padding: EdgeInsets.all(5),
          child: Text("Кошки",
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 14)),
        ),
      ]),
    );
  }
}
