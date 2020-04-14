import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:green/src/info_views/short_info.dart';
import 'package:green/src/info_views/statistic.dart';
import 'package:green/src/info_views/news.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatefulWidget {
  State<InfoPage> createState() => _InfoPageView();
}

class _InfoPageView extends State<InfoPage> {
  int currentTabIndex = 0;

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  List<Widget> tabs = [
    ShortInfoView(),
    StatisticView(),
    NewsView()
  ];

  Widget _currentView(int index) {
    switch (index) {
      case 0:
        return ShortInfoView();
        break;
          case 1:
            return StatisticView();
            break;
          case 2:
            return NewsView();
            break;
          default:
            return ShortInfoView();
            break;
        }
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.red[800],
        items: [
        BottomNavigationBarItem(
          icon: Icon(Typicons.chart_pie), title: Text("Now", style: GoogleFonts.nunito(fontSize: 14.0, fontWeight: FontWeight.w500),)),
        BottomNavigationBarItem(
          icon: Icon(Typicons.chart_line), title: Text("Statistic", style: GoogleFonts.nunito(fontSize: 14.0, fontWeight: FontWeight.w500),)),
        BottomNavigationBarItem(
          icon: Icon(Typicons.news), title: Text("News", style: GoogleFonts.nunito(fontSize: 14.0, fontWeight: FontWeight.w500),))
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
                child: _currentView(index)
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
          Text('$city', style: GoogleFonts.montserrat(color: Colors.grey[800], fontSize: 72.0, fontWeight: FontWeight.bold)),
          Text('$date', style: GoogleFonts.montserrat(color: Colors.grey[800], fontSize: 24.0, fontWeight: FontWeight.bold))
        ],
      )
    );
  }
}