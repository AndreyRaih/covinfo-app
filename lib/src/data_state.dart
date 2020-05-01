import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class LocationModel extends ChangeNotifier {
  String location;
  var locationObj;
  void setLocation (String _data) {
    location = _data;
  }
  void setLocationObject (obj) {
    locationObj = obj;
    print(locationObj);
  }
}