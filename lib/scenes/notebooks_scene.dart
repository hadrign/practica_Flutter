import 'package:everpobre/scenes/notes_scene.dart';
import 'package:flutter/material.dart';
import 'package:everpobre/domain/notebooks.dart';
import 'dart:math';
import 'package:everpobre/text_resources.dart';
import 'package:everpobre/domain/notebook.dart';

class NotebooksListView extends StatefulWidget {
  final Notebooks _model;

  const NotebooksListView(Notebooks model) : _model = model;

  @override
  _NotebooksListViewState createState() => _NotebooksListViewState();
}

class _NotebooksListViewState extends State<NotebooksListView> {
  void modelDidChange() {
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    widget._model.addListener(modelDidChange);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget._model.removeListener(modelDidChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._model.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              Navigator.pushNamed(context, NotebookDetailWidget.routeName,
                  arguments: widget._model[index]);
            },
            child: NotebookSliver(widget._model, index));
      },
    );
  }
}

class NotebookSliver extends StatefulWidget {
  final Notebooks notebooks;
  final int index;

  const NotebookSliver(Notebooks notebooks, int index)
      : this.notebooks = notebooks,
        this.index = index;

  @override
  _NotebookSliverState createState() => _NotebookSliverState();
}

class _NotebookSliverState extends State<NotebookSliver> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        widget.notebooks.removeAt(widget.index);

        Scaffold.of(context).showSnackBar(
          const SnackBar(
            content: Text("Notebook has been deleted!"),
          ),
        );
        setState(() {});
      },
      background: Container(
        color: Colors.red,
      ),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.library_books),
          title: Text("New Notebook"),
          subtitle:
              Text("Note inside: ${widget.notebooks[widget.index].length}"),
        ),
      ),
    );
  }
}

final Notebooks modelNotebooks = Notebooks.testDataBuilder();

class NotebooksWidget extends StatelessWidget {
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextResources.appName),
      ),
      body: NotebooksListView(modelNotebooks), //NotesListView(model)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modelNotebooks.add(Notebook.testDataBuilder());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
