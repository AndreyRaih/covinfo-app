import 'package:flutter/cupertino.dart';
import 'package:green/src/place.dart';
import 'package:green/src/info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      initialRoute: '/',
      routes: {
        '/': (_) => PlacePage(),
        'info': (_) => InfoPage(),
      },
    );
  }
}
