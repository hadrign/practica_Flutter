import 'package:everpobre/extensions/date_time.dart';

class Note {
  String _body = "";

  // Fields
  String get body => _body;
  set body(String newValue) {
    _body = newValue;
    _modificationDate = DateTime.now();
  }

  DateTime _creationDate;
  DateTime _modificationDate;

  DateTime get creationDate => _creationDate;
  DateTime get modificationDate => _modificationDate;

  // Constructores
  Note(String contents) : _body = contents {
    _modificationDate = DateTime.now();
    _creationDate = DateTime.now();
  }

  Note.empty() : this("");

  /*
   * Métodos heredados de Object
   * toString()
   * ==
   * hashCode, sabiendo que dos objectos son iguales cuando tienen el mismo hashCode
   */

  @override
  String toString() {
    return "<$runtimeType: $body";
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    } else {
      return other is Note &&
          other._body == body &&
          other.creationDate.almostEqual(_creationDate) &&
          other.modificationDate.almostEqual(_modificationDate);
    }
  }

  @override
  int get hashCode {
    final proxy = DateTime(
        _creationDate.year,
        _creationDate.month,
        _creationDate.day,
        _creationDate.hour,
        _creationDate.minute,
        _creationDate.second);
    return proxy.hashCode;
  }

  /**
   * Encasquetar ChangeNotifier y llamas a notifyListeners() cuando algo cambia
   */

}
