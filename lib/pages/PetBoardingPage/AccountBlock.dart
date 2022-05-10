import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import '../BasePage.dart';
import 'Overexposure.dart';
import 'package:http/http.dart' as http;

//Виджет для блока-виджета аккаунта
class AccountBlock extends StatefulWidget {
  final Overexposure account;
  final int index;
  AccountBlock(this.account, this.index);

  @override
  State<AccountBlock> createState() => _AccountBlockState(index);
}

class _AccountBlockState extends State<AccountBlock> {
  final int index;
  _AccountBlockState(this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: const Offset(1.0, 1.0),
                  spreadRadius: 0.0,
                )
              ]),
          //padding: EdgeInsets.all(10),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(children: [
                    Avatar(
                      shape: AvatarShape.circle(50),
                      name: widget.account.firstname + widget.account.lastname,
                    ),
                  ])),
              Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 223, 142, 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 125,
                      width: 220,
                      padding: EdgeInsets.all(5),
                      child: Center(
                          child: ListView(children: [
                        Text(
                            widget.account.firstname +
                                " " +
                                widget.account.lastname +
                                '\n' +
                                widget.account.animal +
                                '\n' +
                                widget.account.cost.toString() +
                                ' руб/день',
                            maxLines: 9,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.comfortaa(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w800,
                                fontSize: 15)),
                        TextButton(
                            onPressed: () =>
                                _displayDialogInfo(context, widget.account),
                            child: Text('Подробнее',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.comfortaa(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13)))
                      ])),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //accounts = k;
  _displayDialogInfo(BuildContext context, Overexposure user) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      title: Text(
        'Информация: ',
        style: Theme.of(context).textTheme.headline1,
      ),
      actions: [
        ElevatedButton(
          child: Text(
            'Ок',
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
        child: Column(
          children: [
            InfoString("Имя", user.firstname + " " + user.lastname),
            InfoString("Кого готовы взять на передержку", user.animal),
            InfoString("Контакты", user.email),
            InfoString("Стоимость передержки", user.cost.toString()),
            InfoString("Район", user.district),
            InfoString("Пожелания", user.oNote),
          ],
        ),
      ),
    );

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
}

//Виджет для блока-виджета аккаунта
class MyAccountBlockO extends StatefulWidget {
  final Overexposure account;
  final int index;
  MyAccountBlockO(this.account, this.index);

  @override
  State<MyAccountBlockO> createState() => _MyAccountBlockStateO(index);
}

class _MyAccountBlockStateO extends State<MyAccountBlockO> {
  final int index;
  _MyAccountBlockStateO(this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 7, right: 7),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: const Offset(1.0, 1.0),
                spreadRadius: 0.0,
              )
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(children: [
                    Avatar(
                      shape: AvatarShape.circle(50),
                      name: widget.account.firstname + widget.account.lastname,
                    ),
                  ])),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 223, 142, 1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 220,
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              widget.account.firstname +
                                  " " +
                                  widget.account.lastname +
                                  '\n' +
                                  widget.account.animal +
                                  '\n' +
                                  widget.account.cost.toString() +
                                  ' руб/день',
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.comfortaa(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15),
                            ),
                          ),
                          Container(
                            //padding: Edge.,
                            child: TextButton(
                              onPressed: () =>
                                  _displayDialogInfo(context, widget.account),
                              child: Text(
                                'Подробнее',
                                overflow: TextOverflow.ellipsis,
                                //textAlign: TextAlign.center,
                                style: GoogleFonts.comfortaa(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          Container(
                            child: IconButton(
                              onPressed: () {
                                delete(widget.account);
                                //update();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomePage(1),
                                  ),
                                );
                              },
                              icon: Icon(Icons.delete, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Response> delete(Overexposure overexposure) async {
    int id = overexposure.overexposureId;
    var response = http.delete(
      Uri.parse(
        Uri.encodeFull(
            'http://vadimivanov-001-site1.itempurl.com/Delete/DeleteOverexposure?overexposure_id=$id'),
      ),
      headers: {"Content-Type": "application/json", "Conten-Encoding": "utf-8"},
    );
    return response;
  }

  _displayDialogInfo(BuildContext context, Overexposure user) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      title: Text(
        'Информация: ',
        style: Theme.of(context).textTheme.headline1,
      ),
      actions: [
        ElevatedButton(
          child: Text(
            'Ок',
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
        child: Column(
          children: [
            InfoString("Имя", user.firstname + " " + user.lastname),
            InfoString("Кого готовы взять на передержку", user.animal),
            InfoString("Контакты", user.email),
            InfoString("Стоимость передержки", user.cost.toString()),
            InfoString("Район", user.district),
            InfoString("Пожелания", user.oNote),
          ],
        ),
      ),
    );

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
}

class InfoString extends StatelessWidget {
  final String nameField, info;
  BuildContext context;
  InfoString(this.nameField, this.info);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(43, 0, 0, 0),
              blurRadius: 5,
              offset: const Offset(0.0, 0.0),
              spreadRadius: 2.0,
            ),
          ],
          color: Color.fromARGB(202, 242, 242, 242),
          border: Border.all(color: Color.fromARGB(202, 242, 242, 242)),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  nameField,
                  softWrap: true,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            Container(
              //padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  info,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            )
          ],
        ));
  }
}
