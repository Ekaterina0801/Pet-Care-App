import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/pages/ProfilePage/vaccinationsrepo.dart';

import 'Vaccination.dart';
import 'VaccinationPage.dart';

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

  int vaccinationId;

  int userID;

  int petId;

  String type;

  String date;

  String document;

  bool revactination;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color.fromRGBO(255, 223, 142, 100)),
        child: Column(
          children: [
            Image.asset(photos[0]),
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
            Container(
              //decoration:
              //    BoxDecoration(color: Color.fromRGBO(255, 223, 142, 100)),
              child: Row(
                children: [
                  Container(
                    //padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(18),
                    child: Text(
                      widget.vac.type,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.comfortaa(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  IconButton(onPressed: ()=>deleteVacc(widget.vac,update), icon: Icon(Icons.delete))
                ],
              ),
            ),
            
          ],
        ),
        );
  }
}

void deleteVacc(Vaccination v,void update())
{
  RepositoryVaccinations().delete(v);
  update();
}