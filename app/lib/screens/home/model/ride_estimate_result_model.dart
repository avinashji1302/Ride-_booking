import 'package:app/screens/home/model/ride_model.dart';
import 'package:app/screens/home/model/vehicle_fare_model.dart';

class RideEstimateResultModel {
  final Ride ride;
  final List<VehicleFare> allVehicleFares;

  RideEstimateResultModel({
    required this.ride,
    required this.allVehicleFares,
  });

  factory RideEstimateResultModel.fromJson(Map<String, dynamic> json) {
    return RideEstimateResultModel(
      ride: Ride.fromJson(json['ride']),
      allVehicleFares: (json['allVehicleFares'] as List)
          .map((e) => VehicleFare.fromJson(e))
          .toList(),
    );
  }
}
