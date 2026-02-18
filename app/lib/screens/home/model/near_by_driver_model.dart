class NearByDriverModel {
  final List<Driver> drivers;

  NearByDriverModel({required this.drivers});

  factory NearByDriverModel.fromJson(Map<String, dynamic> json) {
    return NearByDriverModel(
      drivers: (json['drivers'] as List<dynamic>? ?? [])
          .map((e) => Driver.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drivers': drivers.map((e) => e.toJson()).toList(),
    };
  }
}

class Driver {
  final String id;
  final String mobile;
  final String firstName;
  final String lastName;
  final Location location;

  Driver({
    required this.id,
    required this.mobile,
    required this.firstName,
    required this.lastName,
    required this.location,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'] ?? '',
      mobile: json['mobile'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mobile': mobile,
      'firstName': firstName,
      'lastName': lastName,
      'location': location.toJson(),
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: (json['coordinates'] as List<dynamic>? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }

  double get longitude => coordinates.isNotEmpty ? coordinates[0] : 0.0;
  double get latitude => coordinates.length > 1 ? coordinates[1] : 0.0;
}