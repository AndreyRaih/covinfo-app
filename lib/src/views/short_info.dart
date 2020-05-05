import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:green/src/share_state/main.dart';
import 'package:green/src/shared/fade_in_transition.dart';

class ShortInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Consumer<StateModel>(
          builder: (context, model, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FadeInTransition(duration: Duration(milliseconds: 350), child: _InfoBlock(
                  label: 'Totaly',
                  text: model.covidData.confirmed.toString(),
                  difference: '312',
                  differencePercentage: '24%'
                )),
                FadeInTransition(duration: Duration(milliseconds: 450), child: _InfoBlock(
                  label: 'Recovered',
                  text: model.covidData.recovered.toString(),
                  difference: '46',
                  differencePercentage: '15%'
                )),
                FadeInTransition(duration: Duration(milliseconds: 500), child: _InfoBlock(
                  label: 'Deaths',
                  text: model.covidData.dead.toString(),
                  difference: '2',
                  differencePercentage: '8%'
                ))
              ]
            );
          }
      );
  }
}

class _InfoBlock extends StatelessWidget {
  _InfoBlock({@required this.label, @required this.text, this.difference, this.differencePercentage});
  final String label;
  final String text;
  final String difference;
  final String differencePercentage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.symmetric(vertical: 12.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.grey[300],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$label:', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 24.0)),
              Center(child: Text(text, style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w800, fontSize: 72.0))),
            ]
          )
        ),
        /* Positioned(
          right: 0,
          child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.red[800],
              ),
              child: Text('+$difference ($differencePercentage)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0)),
            ),
        ) */
      ],
    );
  }
}