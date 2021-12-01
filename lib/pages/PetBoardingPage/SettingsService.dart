import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/PetBoardingPage/MyAccountWidget.dart';
import 'package:pet_care/repository/accounts.dart';

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
  String district = "Советский район";
  String price = "1000";
  var _selected_dist = "";
  var _selected_price = "";
  _changeDistrict(String text) {
    setState(() => district = text);
  }

  _changePrice(String text) {
    setState(() => price = text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        backgroundColor: Color.fromRGBO(255, 223, 142, 10),
        elevation: 0,
        title: Text("Настройки профиля для сервиса",
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 24)),
      ),
      body: ListView(
        children: [
          MyAccountWidget(accounts[0]),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Район: $district ",
                      style: GoogleFonts.comfortaa(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 16))),
              IconButton(
                  icon: Icon(Icons.edit, size: 16),
                  onPressed: () => _displayDialogDistrict(context)),
            ],
          ),
          //Container(child: SetKindOfPets()),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Стоимость: $price руб./день",
                      style: GoogleFonts.comfortaa(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          fontSize: 16))),
              IconButton(
                  icon: Icon(Icons.edit, size: 16),
                  onPressed: () => _displayDialogPrice(context)),
            ],
          ),
        ],
      ),
    );
  }

  _displayDialogDistrict(BuildContext context) async {
    _selected_dist = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
            child: AlertDialog(
          title: Text('Редактировать район'),
          actions: [
            FlatButton(
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
              initialValue: district,
              style: GoogleFonts.comfortaa(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
              onChanged: _changeDistrict,
              validator: (email) {
                if (isDistrictValid(email))
                  return null;
                else
                  return 'Введите корректный район';
              },
            ),
          ),
        ));
      },
    );

    if (_selected_dist != null) {
      setState(() {
        _selected_dist = _selected_dist;
      });
    }
  }

  _displayDialogPrice(BuildContext context) async {
    _selected_price = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
            child: AlertDialog(
          title: Text('Редактировать стоимость'),
          actions: [
            FlatButton(
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
          ),
        ));
      },
    );

    if (_selected_price != null) {
      setState(() {
        _selected_price = _selected_price;
      });
    }
  }

  bool isDistrictValid(String district) {
    RegExp regex = new RegExp(r'[А-ЯЁ][а-яё]*$');
    return regex.hasMatch(district);
  }

  bool isPriceValid(String price) {
    RegExp regex = new RegExp(r'[0-9]*$');
    return regex.hasMatch(price);
  }
}

class SetKindOfPets extends StatefulWidget {
  @override
  _SetKindOfPetsState createState() => _SetKindOfPetsState();
}

class _SetKindOfPetsState extends State<SetAgreement> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(children: [
          Checkbox(
              checkColor: Colors.black,
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value;
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
        ]),
        Row(children: [
          Checkbox(
              checkColor: Colors.black,
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value;
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
      ],
    );
  }
}
