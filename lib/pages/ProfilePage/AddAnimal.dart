import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:pet_care/dommain/myuser.dart';
import 'package:pet_care/pages/Registration/util/shared_preference.dart';
import 'package:pet_care/pages/Registration/util/widgets.dart';

import '../BasePage.dart';

class AddAnimal extends StatefulWidget {
  @override
  State<AddAnimal> createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {
  String _animal,_name,_breed,_dateofbirthday,_gender, _color; int _weight;
  int userID;
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    
    Future<MyUser> getUserData() => UserPreferences().getUser();
    final animalField = 
    TextFormField(
      autofocus: false,
      //obscureText: true,
      validator: (value) => value.isEmpty ? "Введите вид питомца" : null,
      onSaved: (value) => _animal = value,
      decoration: buildInputDecoration("Вид питомца", Icons.pets,
    ));

    final nameField = 
    TextFormField(
      autofocus: false,
      //obscureText: true,
      validator: (value) => value.isEmpty ? "Введите имя питомца" : null,
      onSaved: (value) => _name = value,
      decoration: buildInputDecoration("Имя питомца", Icons.pets,
    ));
    final breedField = 
    TextFormField(
      autofocus: false,
      //obscureText: true,
      validator: (value) => value.isEmpty ? "Введите породу питомца" : null,
      onSaved: (value) => _breed = value,
      decoration: buildInputDecoration("Порода питомца", Icons.pets,
    ));

    final datebirthdayField = 
    TextFormField(
      autofocus: false,
      //obscureText: true,
      validator: (value) => value.isEmpty ? "Введите дату рождения питомца (формат день.месяц.год)" : null,
      onSaved: (value) => _dateofbirthday = value,
      decoration: buildInputDecoration("Дата рождения питомца", Icons.pets,
    ));

    final genderField = 
    TextFormField(
      autofocus: false,
      //obscureText: true,
      validator: (value) => value.isEmpty ? "Введите пол питомца" : null,
      onSaved: (value) => _gender = value,
      decoration: buildInputDecoration("Пол питомца", Icons.pets,
    ));

    final colorField = 
    TextFormField(
      autofocus: false,
      //obscureText: true,
      //validator: (value) => value.isEmpty ? "Введите окрас питомца" : null,
      onSaved: (value) => _color = value,
      decoration: buildInputDecoration("Окрас питомца", Icons.pets,
    ));

    final weightField = 
    TextFormField(
      autofocus: false,
      //obscureText: true,
      //validator: (value) => value.isEmpty ? "Введите вес питомца" : null,
      onSaved: (value) => _weight = int.parse(value),
      decoration: buildInputDecoration("Вес питомца", Icons.pets,
    ));
     final form = formKey.currentState;
     
    return BasePage(
      title: "Добавление питомца",
      body: FutureBuilder( 
        future: getUserData(),
        builder: (context,snapshot) {
        //userID = snapshot.data.userID;
        switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else userID=snapshot.data.userid;

                      //UserPreferences().removeUser();
                    
                }
        return Form(
          key: formKey,
          child: ListView(
          children: [
            
                 SizedBox(height: 15.0),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child:Text("Вид питомца",
                    style: GoogleFonts.comfortaa(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400, 
                    fontSize: 14),
                    ),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: animalField),
                  SizedBox(height: 20.0),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child:Text("Имя питомца",
                    style: GoogleFonts.comfortaa(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400, 
                    fontSize: 14),
                    ),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: nameField),
                  SizedBox(height: 20.0),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child:Text("Порода питомца",
                    style: GoogleFonts.comfortaa(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400, 
                    fontSize: 14),
                    ),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: breedField),
                  SizedBox(height: 20.0),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child:Text("Дата рождения питомца",
                    style: GoogleFonts.comfortaa(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400, 
                    fontSize: 14),
                    ),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: datebirthdayField),
                  SizedBox(height: 20.0),
                  
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child:Text("Пол питомца",
                    style: GoogleFonts.comfortaa(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400, 
                    fontSize: 14),
                    ),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: genderField),
                  SizedBox(height: 20.0),
                  
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child:Text("Окрас питомца",
                    style: GoogleFonts.comfortaa(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400, 
                    fontSize: 14),
                    ),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: colorField),
                  SizedBox(height: 20.0),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child:Text("Вес питомца",
                    style: GoogleFonts.comfortaa(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400, 
                    fontSize: 14),
                    ),
                  ),

                  SizedBox(height: 5.0),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    child: weightField),
                  SizedBox(height: 20.0),

                  //longButtons("Добавить", addPet()),
                  Container(
                    child: ElevatedButton(child: Text("Добавить"),
                    onPressed: () => { if(formKey.currentState.validate()){
      formKey.currentState.save(), 

                      addPet(userID, _animal, _name, _breed, _dateofbirthday, _gender, _color, _weight),Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                             
                            ),
                          ),
                        ),
                     } else print("error validate"),}
                  )
          )]),
          
        );
        
        }
        )
        );
  }
}

Future<Map<String,dynamic>> addPet(int userID,String animal,String name,String breed,String dateofbirthday,String gender, String color,
  int weight) async{
  final Map<String,dynamic> petData = 
  {
    'UserID':userID,
    'Animal':animal,
    'Name':name,
    'Breed':breed,
    'DateOfBirthday':dateofbirthday,
    'Gender':gender,
    'Color':color,
    'Weight':weight,
    'PetID':1,
  };
  var response = await post(Uri.parse('https://petcare-app-3f9a4-default-rtdb.europe-west1.firebasedatabase.app/Pets.json'),
  body: json.encode(petData));
  var result;
  if (response.request!=null)
    result = {
        'status': true,
        'message': 'Successfully add',
        'data': null
      };
    else{
      result = {
        'status': false,
        'message': 'Adding failed',
        'data': null
      };
    }
    return result;
  }
