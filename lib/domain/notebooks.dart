import 'package:flutter/material.dart';
import 'package:everpobre/domain/notebook.dart';

class Notebooks with ChangeNotifier {
  static final shared = Notebooks();

  final List<Notebook> _notebooks = [];

  int get length => _notebooks.length;

  //Constructors
  Notebooks();

  Notebooks.testDataBuilder() {
    _notebooks.addAll(List.generate(20, (index) => Notebook.testDataBuilder()));
  }

  //Access
  Notebook operator [](int index) {
    return _notebooks[index];
  }

  //Mutators
  bool remove(Notebook notebook) {
    final nb = _notebooks.remove(notebook);
    notifyListeners();
    return nb;
  }

  Notebook removeAt(int index) {
    final Notebook nb = _notebooks.removeAt(index);
    notifyListeners();
    return nb;
  }

  void add(Notebook notebook) {
    _notebooks.insert(0, notebook);
    notifyListeners();
  }

  @override
  String toString() {
    return "<$runtimeType: $length notebooks";
  }
}
