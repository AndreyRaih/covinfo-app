import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:green/src/shared/fade_in_transition.dart';
import 'package:provider/provider.dart';
import 'package:green/src/share_state/main.dart';
import 'package:green/src/data/covid.dart';
import 'package:intl/intl.dart';

class StatisticView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Statistic:', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 36.0,)),
          Divider(color: Colors.grey,),
          FadeInTransition(duration: Duration(milliseconds: 350), child: _IsolateIndex()),
          FadeInTransition(duration: Duration(milliseconds: 400), child: Divider(color: Colors.grey)),
          FadeInTransition(duration: Duration(milliseconds: 450), child: Container(
            margin: EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Cases statistic', style: TextStyle(color: Colors.grey[800], fontSize: 32.0, fontWeight: FontWeight.w500)),
              ],
            )
          )),
          Expanded(child: FadeInTransition(duration: Duration(milliseconds: 500), child: _StatisticView()))
        ],
    );

  }
}

class _IsolateIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentDay = Provider.of<StateModel>(context).currentStatisticDay != null ? Provider.of<StateModel>(context).currentStatisticDay : Provider.of<StateModel>(context).covidHistoryList[Provider.of<StateModel>(context).covidHistoryList.length - 1];
    return Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.symmetric(vertical: 12.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey[200],
      ),
      child: currentDay != null ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Text(new DateFormat.yMMMMEEEEd('en_US').format(DateTime.parse(currentDay.updated)).toString(), style: TextStyle(color: Colors.grey[800], fontSize: 26.0, fontWeight: FontWeight.w600)),
        Divider(color: Colors.grey),
        Text('Confirmed: ${currentDay.confirmed.toString()} (+${currentDay.confirmedDiff.toString()})', style: TextStyle(color: Colors.grey[800], fontSize: 18.0, fontWeight: FontWeight.w500)),
        Text('Deaths: ${currentDay.deaths.toString()} (+${currentDay.deathsDiff.toString()})', style: TextStyle(color: Colors.grey[800], fontSize: 18.0, fontWeight: FontWeight.w500)),
        Divider(color: Colors.grey),
        Row(children: [ 
          Text("So, it's look like a ", style: TextStyle(color: Colors.grey[600], fontSize: 14.0, fontWeight: FontWeight.w500)),
          Text(currentDay.confirmedDiff > 20 ? 'Grow up' : 'Flat', style: TextStyle(color: currentDay.confirmedDiff > 20 ? Colors.red[600] : Colors.green[600], fontSize: 14.0, fontWeight: FontWeight.w500))
        ])
      ]) : null
    );
  }
}

class _StatisticView extends StatefulWidget {
  _StatisticViewState createState() => _StatisticViewState();
}

class _StatisticViewState extends State<_StatisticView> {
  void initState() {
    super.initState();
  }
  _onSelectionChanged(charts.SelectionModel model) {
    Provider.of<StateModel>(context).setCurrentStatisticModel(model.selectedDatum.first.datum);
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<CovidHistory, String>> seriesList = [
      new charts.Series<CovidHistory, String>(
        id: 'Last cases dynamic',
        domainFn: (CovidHistory note, _) => note.updated,
        measureFn: (CovidHistory note, _) => note.confirmed,
        seriesColor: charts.Color.fromHex(code: '#c62727'),
        data: Provider.of<StateModel>(context).covidHistoryList,
      ),
    ];
    return charts.BarChart(
      seriesList,
      animate: true,
      selectionModels: [
        new charts.SelectionModelConfig(
          type: charts.SelectionModelType.info,
          changedListener: _onSelectionChanged,
        )
      ],
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
