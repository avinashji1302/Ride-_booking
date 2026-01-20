import 'package:app/screens/home/model/estimate_response_model.dart/fare_breakdown_model.dart';

class VehicleFare {
  final String vehicleType;
  final double estimatedFare;
  final int surgeMultiplier;
  final FareBreakdown breakdown;

  VehicleFare({
    required this.vehicleType,
    required this.estimatedFare,
    required this.surgeMultiplier,
    required this.breakdown,
  });

  factory VehicleFare.fromJson(Map<String, dynamic> json) {
    return VehicleFare(
      vehicleType: json['vehicleType'],
      estimatedFare: (json['estimatedFare'] as num).toDouble(),
      surgeMultiplier: json['surgeMultiplier'],
      breakdown: FareBreakdown.fromJson(json['breakdown']),
    );
  }
}
