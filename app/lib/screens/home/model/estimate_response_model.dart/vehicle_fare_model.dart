import 'package:app/screens/home/model/estimate_response_model.dart/fare_breakdown_model.dart';




// class VehicleFare {
//   final String vehicleType;
//   final double estimatedFare;
//   final double surgeMultiplier;
//   final FareBreakdown breakdown;

//   VehicleFare({
//     required this.vehicleType,
//     required this.estimatedFare,
//     required this.surgeMultiplier,
//     required this.breakdown,
//   });

//   factory VehicleFare.fromJson(Map<String, dynamic> json) {
//     return VehicleFare(
//       vehicleType: json['vehicleType'] ?? '',
//       estimatedFare: (json['estimatedFare'] as num).toDouble(),
//       surgeMultiplier: (json['surgeMultiplier'] as num).toDouble(),
//       breakdown: FareBreakdown.fromJson(json['breakdown'] ?? {}),
//     );
//   }
// }


// class FareBreakdown {
//   final double base;
//   final double distanceCharge;
//   final double subtotal;
//   final double vehicleMultiplier;
//   final double vehicleAdjusted;
//   final double surgedAmount;
//   final int surgeMultiplier;
//   final double tip;
//   final double total;

//   FareBreakdown({
//     required this.base,
//     required this.distanceCharge,
//     required this.subtotal,
//     required this.vehicleMultiplier,
//     required this.vehicleAdjusted,
//     required this.surgedAmount,
//     required this.surgeMultiplier,
//     required this.tip,
//     required this.total,
//   });

//   factory FareBreakdown.fromJson(Map<String, dynamic> json) {
//     return FareBreakdown(
//       base: (json['base'] as num).toDouble(),
//       distanceCharge: (json['distanceCharge'] as num).toDouble(),
//       subtotal: (json['subtotal'] as num).toDouble(),
//       vehicleMultiplier: (json['vehicleMultiplier'] as num).toDouble(),
//       vehicleAdjusted: (json['vehicleAdjusted'] as num).toDouble(),
//       surgedAmount: (json['surgedAmount'] as num).toDouble(),
//       surgeMultiplier: json['surgeMultiplier'],
//       tip: (json['tip'] as num).toDouble(),
//       total: (json['total'] as num).toDouble(),
//     );
//   }
// }
