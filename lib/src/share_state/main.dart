import 'package:flutter/foundation.dart';
import "package:green/src/data/google_region.dart";
import "package:green/src/data/covid_place.dart";
import "./requests.dart";

class StateModel extends ChangeNotifier {
  GoogleRegion region;
  CovidActual covidData;
  Future setLocation (_data) async {
    region = GoogleRegion(await searchPlace(_data));
    await setRegionData(region.city);
    notifyListeners();
  }
  Future setRegionData(regionName) async {
    covidData = CovidActual(await getCovidInfo(regionName));
    notifyListeners();
  }
}
