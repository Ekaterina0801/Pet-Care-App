import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_care/pages/NotesPage/NotesWidget.dart';
import 'package:pet_care/repository/notesrepo.dart';

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: 16,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          itemBuilder: (BuildContext context, int index) =>
              Container(child: NotesWidget(notes[index]))),
    );
  }
}
