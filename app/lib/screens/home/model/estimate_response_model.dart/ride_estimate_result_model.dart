


class RideEstimateResultModel {
  final Ride ride;
  final List<VehicleFare> allVehicleFares;

  RideEstimateResultModel({
    required this.ride,
    required this.allVehicleFares,
  });

  factory RideEstimateResultModel.fromJson(Map<String, dynamic> json) {
    return RideEstimateResultModel(
      ride: Ride.fromJson(json['ride'] ?? {}),
      allVehicleFares: (json['allVehicleFares'] as List? ?? [])
          .map((e) => VehicleFare.fromJson(e))
          .toList(),
    );
  }
}

class Ride {
  final String id;
  final Location pickupLocation;
  final Location dropLocation;
  final String distance;
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
      id: json['_id']?.toString() ?? '',
      pickupLocation: Location.fromJson(json['pickupLocation'] ?? {}),
      dropLocation: Location.fromJson(json['dropLocation'] ?? {}),
      distance: json['distance']?.toString() ?? '0',
      estimatedFare: (json['estimatedFare'] as List? ?? [])
          .map((e) => EstimatedFare.fromJson(e))
          .toList(),
      status: json['status']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
    );
  }
}

class Location {
  final String type;
  final String latitude;
  final String longitude;
  final String address;

  Location({
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    final coordinates = json['coordinates'] as List? ?? [];

    return Location(
      type: json['type']?.toString() ?? '',
      longitude: coordinates.isNotEmpty
          ? coordinates[0].toString()
          : '0',
      latitude: coordinates.length > 1
          ? coordinates[1].toString()
          : '0',
      address: json['address']?.toString() ?? '',
    );
  }
}

class EstimatedFare {
  final String vehicleType;
  final String estimatedFare;

  EstimatedFare({
    required this.vehicleType,
    required this.estimatedFare,
  });

  factory EstimatedFare.fromJson(Map<String, dynamic> json) {
    return EstimatedFare(
      vehicleType: json['vehicleType']?.toString() ?? '',
      estimatedFare: json['estimatedFare']?.toString() ?? '0',
    );
  }
}

class VehicleFare {
  final String vehicleType;
  final String estimatedFare;
  final String surgeMultiplier;
  final FareBreakdown breakdown;

  VehicleFare({
    required this.vehicleType,
    required this.estimatedFare,
    required this.surgeMultiplier,
    required this.breakdown,
  });

  factory VehicleFare.fromJson(Map<String, dynamic> json) {
    return VehicleFare(
      vehicleType: json['vehicleType']?.toString() ?? '',
      estimatedFare: json['estimatedFare']?.toString() ?? '0',
      surgeMultiplier: json['surgeMultiplier']?.toString() ?? '0',
      breakdown: FareBreakdown.fromJson(json['breakdown'] ?? {}),
    );
  }
}

class FareBreakdown {
  final String base;
  final String distanceCharge;
  final String subtotal;
  final String vehicleMultiplier;
  final String vehicleAdjusted;
  final String surgedAmount;
  final String surgeMultiplier;
  final String tip;
  final String total;

  FareBreakdown({
    required this.base,
    required this.distanceCharge,
    required this.subtotal,
    required this.vehicleMultiplier,
    required this.vehicleAdjusted,
    required this.surgedAmount,
    required this.surgeMultiplier,
    required this.tip,
    required this.total,
  });

  factory FareBreakdown.fromJson(Map<String, dynamic> json) {
    return FareBreakdown(
      base: json['base']?.toString() ?? '0',
      distanceCharge: json['distanceCharge']?.toString() ?? '0',
      subtotal: json['subtotal']?.toString() ?? '0',
      vehicleMultiplier: json['vehicleMultiplier']?.toString() ?? '0',
      vehicleAdjusted: json['vehicleAdjusted']?.toString() ?? '0',
      surgedAmount: json['surgedAmount']?.toString() ?? '0',
      surgeMultiplier: json['surgeMultiplier']?.toString() ?? '0',
      tip: json['tip']?.toString() ?? '0',
      total: json['total']?.toString() ?? '0',
    );
  }
}
