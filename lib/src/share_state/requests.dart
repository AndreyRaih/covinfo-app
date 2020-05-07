import "package:http/http.dart" as http;
import "dart:convert" as convert;

Future searchPlace (location) async {
  String url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${location.latitude},${location.longitude}&radius=10000&key=AIzaSyAGACJrdxHFZK3UEAbktYav9sLHyomcZr0";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    return jsonResponse["results"][0];
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future getCovidInfo (name) async {
  String url = "https://www.trackcorona.live/api/cities/${name}";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    return jsonResponse["data"][0];
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future getCovidHistory (name, date) async {
  String url = "https://covid-api.com/api/reports?date=${date}&city_name=${name}";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    return jsonResponse["data"].length > 0 ? jsonResponse["data"][0] : null;
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future getCovidNews (name) async {
  String url = "https://www.trackcorona.live/api/travel";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    return jsonResponse["data"].where((item) => item["data"].contains(name));
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}