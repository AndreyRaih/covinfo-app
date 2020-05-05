import "package:http/http.dart" as http;
import "dart:convert" as convert;

Future searchPlace (location) async {
  String url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${location.latitude},${location.longitude}&radius=10000&key=AIzaSyAGACJrdxHFZK3UEAbktYav9sLHyomcZr0";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var result = jsonResponse["results"][0];
    return result;
  }
}

Future getCovidInfo (name) async {
  var url = "https://www.trackcorona.live/api/cities/${name}";
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse["data"][0]);
    return jsonResponse["data"][0];
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}