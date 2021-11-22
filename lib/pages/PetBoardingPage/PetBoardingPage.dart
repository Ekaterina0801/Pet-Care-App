import 'package:flutter/material.dart';
import 'package:pet_care/pages/PetBoardingPage/MyAccountWidget.dart';
import 'package:pet_care/repository/accounts.dart';

import 'AccountBlock.dart';

class PetBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ScrollPhysics(),
      children: [
        MyAccountWidget(accounts[0]),        
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
            itemCount: accounts.length,
            itemBuilder: (BuildContext context, int index) =>
                Container(child: AccountBlock(accounts[index]))),
      ],
    );
  }
}
