class GoogleRegion  {
  String city;
  Map<String, dynamic> location;
  DateTime update;
  
  GoogleRegion(data) {
    city = data["name"];
    location = data["location"];
    update = new DateTime.now();
  }
}