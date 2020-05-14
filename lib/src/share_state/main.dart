import 'package:flutter/foundation.dart';
import "package:green/src/share_state/requests.dart";
import "package:green/src/data/region.dart";
import "package:green/src/data/covid.dart";
import 'package:location/location.dart';
import 'package:intl/intl.dart';

class StateModel extends ChangeNotifier {
  Region region;
  CovidActual covidActualData;
  List <CovidHistory> covidHistoryList = [];
  var covidRegionNews = [];
  CovidHistory currentStatisticDay;
  Future initAppData (LocationData location) async {
    await _setLocation(location);
    await _setCovidInfo(region.city);
    await _getHistoryData(region.city);
    await _getRegionCovidNews(region.city);
    notifyListeners();
  }
  Future _setLocation(LocationData location) async {
    region = Region(await searchPlace(location));
  }
  Future _setCovidInfo(String regionName) async {
    covidActualData = CovidActual(await getCovidInfo(regionName));
  }
  Future _getHistoryData(String regionName) async {
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
      if (historyData != null) {
        covidHistoryList.add(CovidHistory(historyData["region"]["cities"][0]));
        covidHistoryList.sort((a, b) => a.updated.compareTo(b.updated));
      };
    }
    dates.forEach((item) => _addDateRegionData(item));
  }
  Future _getRegionCovidNews(String regionName) async {
    covidRegionNews = await getCovidNews(regionName);
    covidRegionNews = covidRegionNews.where((item) => item["data"].contains('${regionName}')).toList();
  }
  void setCurrentStatisticModel (CovidHistory _data) {
    currentStatisticDay = _data;
    notifyListeners();
  }
}
