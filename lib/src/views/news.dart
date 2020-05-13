import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:green/src/shared/fade_in_transition.dart';
import 'package:provider/provider.dart';
import "package:green/src/share_state/main.dart";

class NewsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List articles = Provider.of<StateModel>(context).covidRegionNews;
    return FadeInTransition(duration: Duration(milliseconds: 300), child: SingleChildScrollView(child: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Last news:', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600, fontSize: 36.0,)),
              Divider(color: Colors.grey,),
              Column(
                children: articles.map((article) => _NewsItem(article)).toList()
              )
            ],
          ),
        )));
  }
}

class _NewsItem extends StatelessWidget {
  var article;
  _NewsItem(_data) {
    article = _data;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(article["location"], style: TextStyle(color: Colors.grey[800], fontSize: 24.0)),
          Text(article["data"], style: TextStyle(color: Colors.grey[600], fontSize: 16.0)),
        ],
      )
    );
  }
}