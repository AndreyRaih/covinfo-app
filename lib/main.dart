import 'package:flutter/cupertino.dart';
import 'package:green/src/screens/place.dart';
import 'package:green/src/screens/info.dart';
import 'package:provider/provider.dart';
import "package:green/src/share_state/main.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateModel(),
      child: CupertinoApp(
        initialRoute: '/',
        routes: {
          '/': (_) => PlacePage(),
          'info': (_) => InfoPage(),
        },
      )
    );
  }
}
