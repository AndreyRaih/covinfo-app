import 'package:flutter/foundation.dart';
import "package:green/src/data/region.dart";
import "package:green/src/data/covid.dart";
import "./requests.dart";
import 'package:intl/intl.dart';

class StateModel extends ChangeNotifier {
  GoogleRegion region;
  CovidActual covidData;
  List <CovidHistory> historyList = [];
  Future setLocation (_data) async {
    region = GoogleRegion(await searchPlace(_data));
    await setCovidInfo(region.city);
    notifyListeners();
  }
  Future setCovidInfo(regionName) async {
    covidData = CovidActual(await getCovidInfo(regionName));
    await _getHistoryData(regionName);
    notifyListeners();
  }
  Future _getHistoryData(regionName) async {
    List <DateTime> dates = [
      DateTime.now().subtract(new Duration(days: 1)),
      DateTime.now().subtract(new Duration(days: 2)),
      DateTime.now().subtract(new Duration(days: 3)),
      DateTime.now().subtract(new Duration(days: 4)),
      DateTime.now().subtract(new Duration(days: 5)),
      DateTime.now().subtract(new Duration(days: 6))
    ];
    void _addDateRegionData (date) async {
      String formatDate = new DateFormat('yyyy-MM-dd', 'en_US').format(date);
      var historyData = await getCovidHistory(regionName, formatDate);
      if (historyData != null) historyList.add(CovidHistory(historyData["region"]["cities"][0]));
    }
    dates.forEach((item) => _addDateRegionData(item));
  }
}
