class RideAcceptedSocketModel {
  final Ride ride;
  final String otp;
  final Driver driver;
  final Vehicle vehicle;

  RideAcceptedSocketModel({
    required this.ride,
    required this.otp,
    required this.driver,
    required this.vehicle,
  });

  factory RideAcceptedSocketModel.fromJson(Map<String, dynamic> json) {
    return RideAcceptedSocketModel(
      ride: Ride.fromJson(json['ride']),
      otp: json['otp'].toString(),
      driver: Driver.fromJson(json['driver']),
      vehicle: Vehicle.fromJson(json['vehicle']),
    );
  }
}

/* ---------------------- RIDE ---------------------- */

class Ride {
  final String id;
  final String status;
  final double distance;
  final double finalFare;
  final int estimatedTime;
  final List<double> pickupLocation;
  final List<double> dropLocation;

  Ride({
    required this.id,
    required this.status,
    required this.distance,
    required this.finalFare,
    required this.estimatedTime,
    required this.pickupLocation,
    required this.dropLocation,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['_id'].toString(),
      status: json['status'].toString(),
      distance: (json['distance'] as num).toDouble(),
      finalFare: (json['finalFare'] as num).toDouble(),
      estimatedTime: json['estimatedTime'] ?? 0,

      // ✅ FIX IS HERE
      pickupLocation:
          (json['pickupLocation']['coordinates'] as List)
              .map((e) => (e as num).toDouble())
              .toList(),

      dropLocation:
          (json['dropLocation']['coordinates'] as List)
              .map((e) => (e as num).toDouble())
              .toList(),
    );
  }
}




class Driver {
  final String id;
  final String fullName;
  final String mobile;
  final double? rating;

  Driver({
    required this.id,
    required this.fullName,
    required this.mobile,
    this.rating,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'],
      fullName: json['fullName'],
      mobile: json['mobile'],
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
    );
  }
}

/* ---------------------- VEHICLE ---------------------- */

class Vehicle {
  final String type;
  final String number;
  final String model;
  final String color;

  Vehicle({
    required this.type,
    required this.number,
    required this.model,
    required this.color,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      type: json['type'],
      number: json['number'],
      model: json['model'],
      color: json['color'],
    );
  }
}
