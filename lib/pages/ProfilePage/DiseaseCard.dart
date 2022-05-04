import 'package:flutter/material.dart';
import 'package:pet_care/pages/ProfilePage/diseaserepo.dart';

import 'Disease.dart';

class DiseaseCard extends StatefulWidget {
  Disease disease;

  DiseaseCard(Disease disease) {
    this.disease = disease;
  }

  @override
  State<DiseaseCard> createState() => _DiseaseCardState();
}

class _DiseaseCardState extends State<DiseaseCard> {
  void update() {
    this.setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          child: Card(
            color: Color.fromRGBO(240, 240, 240, 1),
            shadowColor: Colors.grey,
            child: ListTile(
              title: Text(widget.disease.type,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).copyWith().textTheme.bodyText1),
              subtitle: Text(
                  "Начало: " +
                      widget.disease.dateofbeggining +
                      "\n" +
                      "Конец: " +
                      widget.disease.dateofending,
                  style: Theme.of(context).copyWith().textTheme.bodyText1),
            ),
          ),
        ),
        Container(
          child: TextButton(
            onPressed: ()=>deleteDisease(widget.disease,update),
            child: Text(
              'Удалить',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        )
      ],
    );
  }
}

void deleteDisease(Disease v, void update()) {
  RepositoryDiseases().delete(v);
  update();
}
