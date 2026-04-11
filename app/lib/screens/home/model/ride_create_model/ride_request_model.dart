
// ==================== REQUEST MODEL ====================

class RideCreatedRequestModel {
  final LocationPoints pickupLocation;
  final LocationPoints dropLocation;
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

class LocationPoints {
  final String type;
  final List<double> coordinates;

  LocationPoints({
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