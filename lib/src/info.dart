import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:green/src/info_views/short_info.dart';
import 'package:green/src/info_views/statistic.dart';
import 'package:green/src/info_views/news.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:location/location.dart';
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import "package:green/src/data/region.dart";
import 'package:provider/provider.dart';
import 'package:green/src/data_state.dart';
class InfoPage extends StatefulWidget {
  State<InfoPage> createState() => _InfoPageView();
}

class _InfoPageView extends State<InfoPage> {

  List<Widget> tabs = [
    ShortInfoView(),
    StatisticView(),
    NewsView()
  ];

  @override
  void initState () {
    super.initState();
  }

  Widget _currentView(int index) {
    var currentView;
    currentView = tabs[index];
    return currentView;
  }
  
  Future _getLocationInfo (model) async {
    var currentRegion = await _getCovidInfo();
    currentRegion.forEach((item) => {
      if (item["location"].contains(model.location)) {
        model.setLocationObject(item)
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.red[800],
        items: [
        BottomNavigationBarItem(
          icon: Icon(Typicons.chart_pie), title: Text("Now", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),)),
        BottomNavigationBarItem(
          icon: Icon(Typicons.chart_line), title: Text("Statistic", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),)),
        BottomNavigationBarItem(
          icon: Icon(Typicons.news), title: Text("News", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),))
        ]),
      tabBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 24.0, bottom: 48.0),
                child: _HeaderView(
                  city: 'Moscow',
                  date: '25.02.2020 16:53'
                )
              ),
              Expanded(
                child: Consumer<LocationModel>(
                builder: (context, model, child) {
                  return FutureBuilder(
                    future: _getLocationInfo(model),
                    builder: (BuildContext context, AsyncSnapshot snapshot) { 
                      return _currentView(index);
                    }
                  );
                })
              )
            ]
          )
        );
      });
  }
}

class _HeaderView extends StatelessWidget {
  _HeaderView({this.city, this.date});
  final String city;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('$city', style: TextStyle(color: Colors.grey[800], fontSize: 72.0, fontWeight: FontWeight.bold)),
          Text('$date', style: TextStyle(color: Colors.grey[800], fontSize: 24.0, fontWeight: FontWeight.bold))
        ],
      )
    );
  }
}

Future _getCovidInfo() async {
  var url = 'https://www.trackcorona.live/api/cities';
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    return jsonResponse["data"];
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}