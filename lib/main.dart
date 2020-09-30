import 'package:everpobre/domain/note.dart';
import 'package:everpobre/domain/notebook.dart';
import 'package:everpobre/domain/notebooks.dart';
import 'package:everpobre/scenes/notes_scene.dart';
import 'package:everpobre/scenes/notebooks_scene.dart';
import 'package:flutter/material.dart';
import 'package:everpobre/text_resources.dart';

final Notebook model = Notebook.testDataBuilder();
final Notebooks modelNotebooks = Notebooks.testDataBuilder();

void main() {
  runApp(TreeBuilder());
}

class TreeBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF388E3C),
        accentColor: Color(0xFFFFC107),
      ),
      title: TextResources.appName,
      home: Scaffold(
        appBar: AppBar(
          title: Text(TextResources.appName),
        ),
        body: NotebooksListView(modelNotebooks), //NotesListView(model)
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.add(Note("Una Nueva Nota"));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
