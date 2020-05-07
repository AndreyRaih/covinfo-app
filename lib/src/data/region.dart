class Region {
  String city;
  Map<String, dynamic> location;
  DateTime update;
  
  Region(data) {
    city = data["name"];
    location = data["location"];
    update = new DateTime.now();
  }
}