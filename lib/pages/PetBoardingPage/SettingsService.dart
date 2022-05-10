import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/pages/NotesPage/widgets/NotesPage.dart';
import 'package:pet_care/pages/PetBoardingPage/Overexposure.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dommain/myuser.dart';
import '../CalendarPage/Message.dart';
import '../ProfilePage/ProfilePage.dart';
import '../Registration/util/shared_preference.dart';
import '../Registration/util/widgets.dart';
import 'AccountBlock.dart';
import 'package:http/http.dart' as http;

//Страница для настроек аккаунта для сервиса передержки
class SettingsService extends StatefulWidget {
  String email;
  String district;
  String kindofanimal;
  String price;
  int userId;
  SettingsService(
      this.email, this.district, this.kindofanimal, this.price, this.userId);

  @override
  _SettingsServiceState createState() => _SettingsServiceState();
}

  
class _SettingsServiceState extends StateMVC {
  MyUserController _controller;

  _SettingsServiceState(): super(MyUserController()) {
    _controller = controller as MyUserController;
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
  Future<Map<String, dynamic>> _changeInfo(
      String newtext, int id, String what) async {
    final Map<String, dynamic> data = {
      'what': what,
      'id': id,
      'new_value': newtext,
    };
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (what == "email")
      prefs.setString('email', newtext);
    else if (what == "district") prefs.setString('district', newtext);

    var response = await http.post(
      Uri.parse(Uri.encodeFull(
          'http://vadimivanov-001-site1.itempurl.com/Update/UpdateInformation')),
      body: jsonEncode(data),
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

  void update() {
    this.setState(() {});
  }
  MyUser user;
  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    List<Overexposure> overexposures = [];
    return Scaffold(
      appBar: AppBar(
        actions: [],
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 223, 142, 10),
        title: Text("Настройки",
            style: Theme.of(context).copyWith().textTheme.headline2),
      ),
      body: FutureBuilder(
        future: getMyOverexposures(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
          overexposures = snapshot.data;
          //district = overexposures[0].district;
          //email = overexposures[0].email;
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
                      child: Text("Контакты: "+user.email,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).copyWith().textTheme.labelSmall),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, size: 16),
                      onPressed: () => _displayDialogContacts(user.userid),
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
                      child: Text("Район: "+user.district,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).copyWith().textTheme.labelSmall),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, size: 16),
                      onPressed: () => _displayDialogDistrict(user.userid),
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
                                style: Theme.of(context).copyWith().textTheme.labelSmall),
                          ),
                        ]),
                    SetKindPets(),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text(
                    'Добавить передержку',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
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
        }
        },
      ),
    );
  }

  _displayDialogPrice(BuildContext context, int id) {
    final formKey = new GlobalKey<FormState>();
    String newtext;
    AlertDialog alert = AlertDialog(
        title: Text('Редактировать стоимость'),
        actions: [
          ElevatedButton(
            child: Text(
              'Принять',
              style: Theme.of(context).copyWith().textTheme.labelSmall,
            ),
            onPressed: () {
              if (formKey.currentState.validate()) {
                _changeInfo(newtext, id, "cost");
                update();
              }
              Navigator.of(context).pop();
            },
          )
        ],
        content: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            maxLength: 12,
            style: Theme.of(context).copyWith().textTheme.bodyText1,
            onChanged: (value) {
              newtext = value;
              //_date = DateTime.now().toString();
            },
            validator: validateDigits,
          ),
        ));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  _displayDialogDistrict(int id) async {
    
    final formKey = new GlobalKey<FormState>();
    String newtext;
    AlertDialog alert = AlertDialog(
        title: Text('Редактировать район'),
        actions: [
          ElevatedButton(
            child: Text(
              'Принять',
              style: Theme.of(context).copyWith().textTheme.labelSmall,
            ),
            onPressed: () {
              if (newtext != "") 
              setState(() {
                _changeInfo(newtext, id, "district");
                user.district=newtext;
              });
              
              update();

              Navigator.of(context).pop();
            },
          )
        ],
        content: Container(
            padding: EdgeInsets.all(10),
            child: SelectFormField(
              autofocus: false,
              items: [
                {'value': 'Ворошиловский', 'label': 'Ворошиловский'},
                {'value': 'Советский', 'label': 'Советский'},
                {'value': 'Железнодорожный', 'label': 'Железнодорожный'},
                {'value': 'Кировский', 'label': 'Кировский'},
                {'value': 'Ленинский', 'label': 'Ленинский'},
                {'value': 'Октябрьский', 'label': 'Октябрьский'},
                {'value': 'Первомайский', 'label': 'Первомайский'},
                {'value': 'Пролетарский', 'label': 'Пролетарский'},
                {'value': 'Другое', 'label': 'Другое'},
              ],
              validator: (value) => value.isEmpty ? "Поле пустое" : null,
              onChanged: (value) => newtext = value,
              onSaved: (value) => newtext = value,
              decoration: buildInputDecoration("Введите район", Icons.home),
            )));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ListView(
            children: [
              alert,
            ],
          );
        });
  }

  _displayDialogContacts(int id) {
    final formKey = new GlobalKey<FormState>();
    String newtext;
    AlertDialog alert = AlertDialog(
        title: Text('Редактировать контакты'),
        actions: [
          ElevatedButton(
            child: Text(
              'Принять',
              style: Theme.of(context).copyWith().textTheme.labelSmall,
            ),
            onPressed: () {
              
                if (newtext != "") {_changeInfo(newtext, id, "email");
                user.email=newtext;
                
                update();
                Navigator.of(context).pop();
                showDialog(
              context: context,
              builder: (BuildContext context) {
                return Message2();
              },
            );
                }
                
              
              
            },
          )
        ],
        content: Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            maxLength: 26,
            style: Theme.of(context).copyWith().textTheme.bodyText1,
            onChanged: (value) {
              newtext = value;
              //_date = DateTime.now().toString();
            },
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
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
                  formKey1.currentState.validate() &&
                          formKey2.currentState.validate() &&
                          formKey3.currentState.validate()
                      ? addOverexposure(animal, cost, oNote)
                      : showDialog(
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

Future<Map<String, dynamic>> addOverexposure(
    String animal, String cost, String oNote) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.get('userId');
  final Map<String, dynamic> data = {
    'user_id': userId,
    'animal': animal,
    'cost': cost,
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
  RegExp regex = new RegExp(r'^(\d+)$');
  if (value.isEmpty) {
    _msg = "Введите число";
  } else if (!regex.hasMatch(value)) _msg = "Можно ввести только целое число";
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
              style: Theme.of(context).copyWith().textTheme.labelSmall),
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
              style: Theme.of(context).copyWith().textTheme.labelSmall),
        ),
      ]),
    );
  }
}

class Message2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        title: Text('Внимание', style: Theme.of(context).textTheme.bodyText2),
        content: Text(
          'Вы изменили электронную почту. При входе в профиль теперь используйте новый email',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          ElevatedButton(
            child: Text('Ок'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
