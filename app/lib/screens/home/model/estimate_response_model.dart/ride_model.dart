import 'package:app/screens/home/model/estimate_response_model.dart/estimated_fare_model.dart';
import 'package:app/screens/home/model/estimate_response_model.dart/location_model.dart';

class Ride {
  final String id;
  final Location pickupLocation;
  final Location dropLocation;
  final double distance;
  final List<EstimatedFare> estimatedFare;
  final String status;
  final String paymentMethod;

  Ride({
    required this.id,
    required this.pickupLocation,
    required this.dropLocation,
    required this.distance,
    required this.estimatedFare,
    required this.status,
    required this.paymentMethod,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['_id'],
      pickupLocation: Location.fromJson(json['pickupLocation']),
      dropLocation: Location.fromJson(json['dropLocation']),
      distance: (json['distance'] as num).toDouble(),
      estimatedFare: (json['estimatedFare'] as List)
          .map((e) => EstimatedFare.fromJson(e))
          .toList(),
      status: json['status'],
      paymentMethod: json['paymentMethod'],
    );
  }
}
