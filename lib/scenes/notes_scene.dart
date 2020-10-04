import 'package:everpobre/domain/notebook.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:everpobre/text_resources.dart';
import 'package:everpobre/domain/note.dart';

class NotesListView extends StatefulWidget {
  final Notebook _model;

  const NotesListView(Notebook model) : _model = model;

  @override
  _NotesListViewState createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
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
    // TODO: implement build
    return ListView.builder(
      itemCount: widget._model.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, NoteDetailWidget.routeName,
                    arguments: widget._model[index])
                .then((value) => {setState(() {})});
          },
          child: NotesSliver(widget._model, index),
        );
      },
    );
  }
}

class NotesSliver extends StatefulWidget {
  final Notebook notebook;
  final int index;

  const NotesSliver(Notebook notebook, int index)
      : this.notebook = notebook,
        this.index = index;

  @override
  _NotesSliverState createState() => _NotesSliverState();
}

class _NotesSliverState extends State<NotesSliver> {
  @override
  Widget build(BuildContext context) {
    final DateFormat fmt = DateFormat("yyyy-mm-dd");

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        widget.notebook.removeAt(widget.index);
        Scaffold.of(context).showSnackBar(
          const SnackBar(
            content: Text("Note has been deleted!"),
          ),
        );

        setState(() {});
      },
      background: Container(
        color: Colors.red,
      ),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.toc),
          title: Text(widget.notebook[widget.index].body),
          subtitle:
              Text(fmt.format(widget.notebook[widget.index].modificationDate)),
        ),
      ),
    );
  }
}

//final Notebook model = Notebook.testDataBuilder();

class NotebookDetailWidget extends StatelessWidget {
  static const routeName = "/notebook";

  @override
  Widget build(BuildContext context) {
    final Notebook notebook =
        ModalRoute.of(context).settings.arguments as Notebook;
    return Scaffold(
      appBar: AppBar(
        title: Text(TextResources.appName),
      ),
      body: NotesListView(notebook),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notebook.add(Note("Una Nueva Nota"));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteDetailWidget extends StatefulWidget {
  static const routeName = "/detail";

  @override
  _NoteDetailWidgetState createState() => _NoteDetailWidgetState();
}

class _NoteDetailWidgetState extends State<NoteDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final Note note = ModalRoute.of(context).settings.arguments as Note;
    final TextEditingController _controller =
        TextEditingController.fromValue(TextEditingValue(
      text: note.body,
    ));

    return Scaffold(
        appBar: AppBar(
          title: Text(TextResources.appName),
        ),
        body: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (value) {
                Text(note.body);
              },
              onSubmitted: (String value) {
                note.body = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }
}
