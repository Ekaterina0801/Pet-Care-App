import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/domain/block/form_block.dart';
import 'package:pet_care/domain/signfolder/signform.dart';

class LoginRegestrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text('Вход и регистрация',
            style: GoogleFonts.comfortaa(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                fontSize: 18)),
        backgroundColor: Color.fromRGBO(255, 223, 142, 10),
      ),
      body: Center(
          child: BlocProvider(
        create: (context) => FormblockBloc(),
        child: LoginForm(),
      )),
    );
  }
}
