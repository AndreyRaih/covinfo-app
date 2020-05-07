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
    updated = new DateFormat.yMMMMEEEEd('en_US').format(DateTime.parse(_data["updated"]));
  }
}

class CovidHistory {
  String name;
  String updated;
  int confirmed;
  int confirmedDiff;
  int deaths;
  int deathsDiff;

  CovidHistory(_data) {
    name = _data["name"];
    updated = _data["last_update"];
    confirmed = _data["confirmed"];
    confirmedDiff = _data["confirmed_diff"];
    deaths = _data["deaths"];
    deathsDiff = _data["deaths_diff"];
  }
}