class RideEstimateRequestModel {


  final RideLocation pickupLocation;
  final RideLocation dropLocation;

  RideEstimateRequestModel({
    required this.pickupLocation,
    required this.dropLocation,
  });

  Map<String, dynamic> toJson() {
    return {
      "pickupLocation": pickupLocation.toJson(),
      "dropLocation": dropLocation.toJson(),
    };
  }
}

class RideLocation {
  final double latitude;
  final double longitude;
  final String address;

  RideLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": "Point",
      "coordinates": [longitude, latitude],
      "address": address,
    };
  }
}


