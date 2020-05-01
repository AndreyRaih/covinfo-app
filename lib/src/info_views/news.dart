import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green/src/utils/fade_in_transition.dart';
class NewsView extends StatelessWidget {
  final List<String> articles = <String>['Article one', 'Article two', 'Article three', 'Article four', 'Article one', 'Article two', 'Article three', 'Article four'];

  @override
  Widget build(BuildContext context) {
    return FadeInTransition(duration: Duration(milliseconds: 350), child: Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Last news', style: TextStyle(color: Colors.grey[800], fontSize: 40.0, fontWeight: FontWeight.w500)),
          ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return _NewsItem();
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.grey),
          )
        ],
      ),
    ));
  }
}

class _NewsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Article title', style: TextStyle(color: Colors.grey[800], fontSize: 24.0)),
          Text('Text. Article content. Text. Article content. Text. Article content.', style: TextStyle(color: Colors.grey[600], fontSize: 16.0)),
          Text('See more in <url>', style: TextStyle(color: Colors.red[800], fontSize: 16.0))
        ],
      )
    );
  }
}