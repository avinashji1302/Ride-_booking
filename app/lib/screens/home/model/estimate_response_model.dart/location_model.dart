class Location {
  final String type;
  final double latitude;
  final double longitude;
  final String address;

  Location({
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      longitude: json['coordinates'][0],
      latitude: json['coordinates'][1],
      address: json['address'],
    );
  }
}
