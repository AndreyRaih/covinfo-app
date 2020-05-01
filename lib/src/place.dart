import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:green/src/data_state.dart';
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
  // Use Google.places API, for defined city for forecast.
  String _placeName = await searchPlace(LatLng(_locationData.latitude, _locationData.longitude));
  Navigator.pushNamed(context, 'info');
  return _placeName;
}
class _GeoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationModel>(
      builder: (context, model, child) {
        return CupertinoButton(
          color: Colors.red[800],
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
          pressedOpacity: 0.5,
          onPressed: () async => model.setLocation(await _getLocation(context)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Typicons.location_outline),
              Text('Find your place', style: TextStyle(color: Colors.white))
            ]
          )
        );
      }
    );
  }
}

Future searchPlace (location) async {
  String url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${location.latitude},${location.longitude}&radius=10000&key=AIzaSyAGACJrdxHFZK3UEAbktYav9sLHyomcZr0";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var result = jsonResponse["results"][0];
    return result["name"];
  }
}