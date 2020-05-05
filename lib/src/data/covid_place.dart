import 'package:intl/intl.dart';

class CovidActual {
  String city;
  String iso;
  int confirmed;
  int recovered;
  int dead;
  String updated;

  CovidActual(_data) {
    city = _data["location"];
    iso = _data["country_code"];
    confirmed = _data["confirmed"] != null ? _data["confirmed"] : 0;
    recovered = _data["recovered"] != null ? _data["recovered"] : 0;
    dead = _data["dead"] != null ? _data["dead"] : 0;
    updated = new DateFormat.yMMMd('en_US').format(DateTime.parse(_data["updated"]));
  }
}