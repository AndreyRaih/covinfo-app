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
            return model.covidActualData == null ? Center(widthFactor: 15.0, heightFactor: 15.0, child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[800]))) : Container(
              padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 12.0),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/background.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24.0, bottom: 48.0),
                    child: Text(model.covidActualData.city, style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(14.0),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(25.0),
                          topRight: new Radius.circular(25.0),
                        ),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey[600],
                            offset: new Offset(0.0, 0.0),
                            blurRadius: 15.0
                          )
                        ],
                      ),
                      child: _currentView(index)
                    )
                  )
                ])
              );
              });
          });
  }
}
