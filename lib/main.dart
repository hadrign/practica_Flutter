import 'package:everpobre/domain/notebook.dart';
import 'package:everpobre/scenes/notes_scene.dart';
import 'package:everpobre/scenes/notebooks_scene.dart';
import 'package:flutter/material.dart';
import 'package:everpobre/text_resources.dart';

final Notebook model = Notebook.testDataBuilder();
//final Notebooks modelNotebooks = Notebooks.testDataBuilder();

void main() {
  runApp(TreeBuilder());
}

class TreeBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFF388E3C),
        accentColor: const Color(0xFFFFC107),
      ),
      title: TextResources.appName,
      routes: {
        NotebooksWidget.routeName: (context) => NotebooksWidget(),
        NotebookDetailWidget.routeName: (context) => NotebookDetailWidget(),
        NoteDetailWidget.routeName: (context) => NoteDetailWidget(),
      },
      initialRoute: NotebooksWidget.routeName,
    );
  }
}
