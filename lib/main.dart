import 'package:flutter/cupertino.dart';
import 'package:green/src/place.dart';
import 'package:green/src/info.dart';
import 'package:provider/provider.dart';
import 'package:green/src/data_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationModel(),
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
