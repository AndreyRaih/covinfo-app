import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';
import 'package:green/src/utils/fade_in_transition.dart';
class StatisticView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInTransition(child: Container(
      padding: EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: <Widget>[
          _IsolateIndex(),
          Divider(color: Colors.grey),
          Container(
            margin: EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Cases statistic', style: TextStyle(color: Colors.grey[800], fontSize: 32.0, fontWeight: FontWeight.w500)),
                Text('Grow up', style: TextStyle(fontSize: 14.0, color: Colors.grey[500]),)
              ],
            )
          ),
          Expanded(child: _StatisticView())
        ],
      )
    )
    );
  }
}

class _IsolateIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 24.0),
      child: Column(children: <Widget>[
        Text('Isolate index:', style: TextStyle(color: Colors.grey[800], fontSize: 40.0, fontWeight: FontWeight.w500)),
        Center(child: Text('3.5', style: TextStyle(color: Colors.red[800], fontSize: 96.0, fontWeight: FontWeight.w900))),
        Text('Most people are aware of isolation.', style: TextStyle(color: Colors.grey[700], fontSize: 16.0)),
        Text('Please, stay home', style: TextStyle(color: Colors.grey[700], fontSize: 16.0))
      ])
    );
  }
}

class _StatisticView extends StatefulWidget {
  _StatisticViewState createState() => _StatisticViewState();
}

class _StatisticViewState extends State<_StatisticView> {
  List<charts.Series<_StatisticCase, String>> seriesList;

  void initState() {
    seriesList = _makeSeriesData();
    super.initState();
  }

  static List<charts.Series<_StatisticCase, String>> _makeSeriesData() {
    final casesData = [
      new _StatisticCase('08-04-2020', 2698),
      new _StatisticCase('09-04-2020', 3202),
      new _StatisticCase('10-04-2020', 3512),
      new _StatisticCase('11-04-2020', 4000),
      new _StatisticCase('12-04-2020', 3356),
    ];

    return [
      new charts.Series<_StatisticCase, String>(
        id: 'Last cases dynamic',
        domainFn: (_StatisticCase note, _) => note.date,
        measureFn: (_StatisticCase note, _) => note.count,
        seriesColor: charts.Color.fromHex(code: '#c62727'),
        data: casesData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
      domainAxis: new charts.OrdinalAxisSpec(
          // Make sure that we draw the domain axis line.
          showAxisLine: true,
          // But don't draw anything else.
          renderSpec: new charts.NoneRenderSpec()),

      // With a spark chart we likely don't want large chart margins.
      // 1px is the smallest we can make each margin.
      layoutConfig: new charts.LayoutConfig(
          leftMarginSpec: new charts.MarginSpec.fixedPixel(40),
          topMarginSpec: new charts.MarginSpec.fixedPixel(40),
          rightMarginSpec: new charts.MarginSpec.fixedPixel(40),
          bottomMarginSpec: new charts.MarginSpec.fixedPixel(40)),
    );
  }
}

class _StatisticCase {
  final String date;
  final int count;

  _StatisticCase(this.date, this.count);
}