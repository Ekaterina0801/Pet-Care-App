import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/PetBoardingPage/Overexposure.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'AccountBlock.dart';
import 'SettingsService.dart';

//страница сервиса передержки
class PetBoardingPage extends StatefulWidget {
  @override
  _PetBoardingPageState createState() => _PetBoardingPageState();
}

class _PetBoardingPageState extends StateMVC {
  MyUserController _controller;
  _PetBoardingPageState() : super(MyUserController()) {
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

  //final formKey = new GlobalKey<FormState>();
  MyUser user;
  List<Overexposure> k = [];
  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    return FutureBuilder(
        future: getOverexposures(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                k = snapshot.data;
              return ListView(
                physics: ScrollPhysics(),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 223, 142, 10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: const Offset(0.0, 0.0),
                            spreadRadius: 0.0,
                          )
                        ]),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Avatar(name: user.firstname + user.lastname),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(user.firstname + " " + user.lastname,
                                maxLines: 12,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).copyWith().textTheme.labelSmall),
                          ),
                        ),
                        Container(
                            child: TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsService(user.email, user.district,"","",user.userid),
                            ),
                          ),
                          child: Text("Перейти к настройкам моих передержек",
                              style: Theme.of(context).copyWith().textTheme.titleSmall),
                        )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Кто готов взять питомцев на передержку: ",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).copyWith().textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: (() => _displayFilter(context)),
                          icon: Icon(Icons.sort, size: 25, color: Colors.grey))
                    ],
                  ),
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 255,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: k.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(child: AccountBlock(k[index], index))),
                ],
              );
          }
        });
  }

  double _value = 20;
  _displayFilter(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(
        'Фильтр: ',
        style: Theme.of(context).copyWith().textTheme.labelLarge,
      ),
      actions: [
        ElevatedButton(
          child: Text(
            'Принять',
            style: Theme.of(context).copyWith().textTheme.labelSmall,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      content: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                "Фильтр",
                style: Theme.of(context).copyWith().textTheme.bodyText1,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                "Вид животного",
                style: Theme.of(context).copyWith().textTheme.bodyText1,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Собаки',
                      style: Theme.of(context).copyWith().textTheme.bodyText1,
                    ),
                    Icon(Icons.check_box_outlined, size: 20)
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    'Кошки',
                    style: Theme.of(context).copyWith().textTheme.bodyText1,
                  ),
                  Icon(Icons.check_box_outlined, size: 20)
                ],
              )
            ],
          ),
          Text(
            "Стоимость",
            style: Theme.of(context).copyWith().textTheme.bodyText1,
          ),
          Slider(
            divisions: 3000,
            label: '${_value.round()}',
            thumbColor: Color.fromRGBO(255, 223, 142, 10),
            activeColor: Color.fromRGBO(255, 223, 142, 10),
            min: 0.0,
            max: 3000.0,
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          )
        ],
      ),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
