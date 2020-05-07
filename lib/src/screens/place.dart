import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import "package:green/src/share_state/main.dart";

class PlacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Center(
                  child: Text('COVINFO', style: TextStyle(color: Colors.grey[800], fontSize: 86.0, fontWeight: FontWeight.w500))
                )
              ),
              Expanded(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      _PlaceInputView(),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12.0),
                        child: _GeoButton()
                      ),
                      Text('Try to find your place in the list', style: TextStyle(color: Colors.grey[700], fontSize: 14.0)),
                      Text('Or use geo', style: TextStyle(color: Colors.grey[700], fontSize: 14.0))
                    ],)
                )
              ),
            ],
          )
        ),
        alignment: Alignment(0.0, 0.0),
      )
    );
  }
}

class _PlaceInputView extends StatefulWidget {
  @override
  _PlaceInput createState() => _PlaceInput();
}

class _PlaceInput extends State<_PlaceInputView> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CupertinoTextField(
        controller: _textController,
        style: TextStyle(),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10)
        ),
        placeholder: 'Search your location...',
      )
    );
  }
}

Future _getLocation (context) async {
  Location location = new Location();
  LocationData _locationData;
  _locationData = await location.getLocation();
  Provider.of<StateModel>(context).initAppData(_locationData);
  Navigator.pushNamed(context, 'info');
}
class _GeoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: Colors.red[800],
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
      pressedOpacity: 0.5,
      onPressed: () async => await _getLocation(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Typicons.location_outline),
          Text('Find your place', style: TextStyle(color: Colors.white))
        ]
      )
    );
  }
}
