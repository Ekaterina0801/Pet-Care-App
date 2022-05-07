import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/ProfilePage/vaccinationsrepo.dart';

import '../BasePage.dart';
import 'Vaccination.dart';
import 'VaccinationPage.dart';

//ignore: must_be_immutable
class VaccinationsCard extends StatefulWidget {
  Vaccination vac;
  VaccinationsCard(Vaccination vac) {
    this.vac = vac;
  }

  @override
  State<VaccinationsCard> createState() => _VaccinationsCardState();
}

class _VaccinationsCardState extends State<VaccinationsCard> {
  void update() {
    this.setState(() {});
  }

  String _info;

  @override
  Widget build(BuildContext context) {
    if (widget.vac.revaccination)
      _info = "Да";
    else
      _info = "Нет";
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(255, 223, 142, 100)),
      child: Column(
        children: [
          Image.asset(photos[0]),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.vac.date,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.comfortaa(
                        decoration: TextDecoration.underline,
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    deleteVacc(widget.vac, update);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(4),
                      ),
                    );
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          Container(
            child: Row(
              children: [
                Container(
                  //padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(18),
                  child: Text(
                    widget.vac.type,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).copyWith().textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Нужна ли ревакцинация: ' + _info,
                  style: Theme.of(context).copyWith().textTheme.bodyText1,
                )),
          )
        ],
      ),
    );
  }
}

void deleteVacc(Vaccination v, void update()) {
  RepositoryVaccinations().delete(v);
  update();
}
