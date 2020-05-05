import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:green/src/views/short_info.dart';
import 'package:green/src/views/statistic.dart';
import 'package:green/src/views/news.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:provider/provider.dart';
import "package:green/src/share_state/main.dart";

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
        return Consumer<StateModel>(
          builder: (context, model, child) {
            return model.covidData == null ? Center(widthFactor: 15.0, heightFactor: 15.0, child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[800]))) : Container(
              padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24.0, bottom: 48.0),
                    child: _HeaderView(
                      city: model.covidData.city,
                      date: model.covidData.updated.toString()
                    )
                  ),
                  Expanded(
                    child: _currentView(index)
                  )
                ])
              );
              });
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
          Text('$city', style: TextStyle(color: Colors.grey[800], fontSize: 36.0, fontWeight: FontWeight.bold)),
          Text('$date', style: TextStyle(color: Colors.grey[800], fontSize: 18.0, fontWeight: FontWeight.bold))
        ],
      )
    );
  }
}
