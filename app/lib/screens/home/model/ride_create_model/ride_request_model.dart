
// ==================== REQUEST MODEL ====================

class RideCreatedRequestModel {
  final Location pickupLocation;
  final Location dropLocation;
  final String vehicleType;
  final String paymentMethod;

  RideCreatedRequestModel({
    required this.pickupLocation,
    required this.dropLocation,
    required this.vehicleType,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      "pickupLocation": pickupLocation.toJson(),
      "dropLocation": dropLocation.toJson(),
      "vehicleType": vehicleType,
      "paymentMethod": paymentMethod,
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    this.type = "Point",
    required this.coordinates,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "coordinates": coordinates,
    };
  }
}