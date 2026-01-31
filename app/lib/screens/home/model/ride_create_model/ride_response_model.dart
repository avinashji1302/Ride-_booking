// class RideCreatedResposeModel {
//   final Ride ride;
//   final List<NearbyDriver> nearbyDrivers;
//   final int estimatedTime;

//   RideCreatedResposeModel({
//     required this.ride,
//     required this.nearbyDrivers,
//     required this.estimatedTime,
//   });

//   factory RideCreatedResposeModel.fromJson(Map<String, dynamic> json) {
//     return RideCreatedResposeModel(
//       ride: Ride.fromJson(json['ride']),
//       nearbyDrivers: (json['nearbyDrivers'] as List)
//           .map((e) => NearbyDriver.fromJson(e))
//           .toList(),
//       estimatedTime: json['estimatedTime'],
//     );
//   }
// }

// // class Ride {
// //   final String id;
// //   final RideLocation pickupLocation;
// //   final RideLocation dropLocation;
// //   final PaymentDetails paymentDetails;
// //   final String rider;
// //   final double distance;
// //   final double finalFare;
// //   final String status;
// //   final String paymentMethod;
// //   final String vehicleType;
// //   final int estimatedTime;
// //   final DateTime createdAt;
// //   final DateTime updatedAt;

// //   Ride({
// //     required this.id,
// //     required this.pickupLocation,
// //     required this.dropLocation,
// //     required this.paymentDetails,
// //     required this.rider,
// //     required this.distance,
// //     required this.finalFare,
// //     required this.status,
// //     required this.paymentMethod,
// //     required this.vehicleType,
// //     required this.estimatedTime,
// //     required this.createdAt,
// //     required this.updatedAt,
// //   });

// //   factory Ride.fromJson(Map<String, dynamic> json) {
// //     return Ride(
// //       id: json['_id'],
// //       pickupLocation: RideLocation.fromJson(json['pickupLocation']),
// //       dropLocation: RideLocation.fromJson(json['dropLocation']),
// //       paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
// //       rider: json['rider'],
// //       distance: (json['distance'] as num).toDouble(),
// //       finalFare: (json['finalFare'] as num).toDouble(),
// //       status: json['status'],
// //       paymentMethod: json['paymentMethod'],
// //       vehicleType: json['vehicleType'],
// //       estimatedTime: json['estimatedTime'],
// //       createdAt: DateTime.parse(json['createdAt']),
// //       updatedAt: DateTime.parse(json['updatedAt']),
// //     );
// //   }
// // }

// class Ride {
//   final String id;
//   final RideLocation pickupLocation;
//   final RideLocation dropLocation;
//   final PaymentDetails paymentDetails;
//   final String rider;
//   final double distance;
//   final double finalFare;
//   final String status;
//   final String paymentMethod;
//   final int estimatedTime;

//   // OPTIONAL fields
//   final String? vehicleType;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   Ride({
//     required this.id,
//     required this.pickupLocation,
//     required this.dropLocation,
//     required this.paymentDetails,
//     required this.rider,
//     required this.distance,
//     required this.finalFare,
//     required this.status,
//     required this.paymentMethod,
//     required this.estimatedTime,
//     this.vehicleType,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Ride.fromJson(Map<String, dynamic> json) {
//     return Ride(
//       id: json['_id'],
//       pickupLocation: RideLocation.fromJson(json['pickupLocation']),
//       dropLocation: RideLocation.fromJson(json['dropLocation']),
//       paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
//       rider: json['rider'],
//       distance: (json['distance'] as num).toDouble(),
//       finalFare: (json['finalFare'] as num).toDouble(),
//       status: json['status'],
//       paymentMethod: json['paymentMethod'],
//       estimatedTime: json['estimatedTime'] ?? 0,

//       // SAFE OPTIONAL PARSING
//       vehicleType: json['vehicleType'],
//       createdAt:
//           json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
//       updatedAt:
//           json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
//     );
//   }
// }


// class RideLocation {
//   final String address;
//   final String type;
//   final List<double> coordinates;

//   RideLocation({
//     required this.address,
//     required this.type,
//     required this.coordinates,
//   });

//   factory RideLocation.fromJson(Map<String, dynamic> json) {
//     return RideLocation(
//       address: json['address'] ?? '',
//       type: json['type'],
//       coordinates: List<double>.from(
//         json['coordinates'].map((e) => (e as num).toDouble()),
//       ),
//     );
//   }
// }

// class PaymentDetails {
//   final double userPaidAmount;
//   final double driverReceivedAmount;
//   final double adminCommissionAmount;
//   final double discountAmount;
//   final double originalFare;
//   final String? promoCode;

//   PaymentDetails({
//     required this.userPaidAmount,
//     required this.driverReceivedAmount,
//     required this.adminCommissionAmount,
//     required this.discountAmount,
//     required this.originalFare,
//     this.promoCode,
//   });

//   // factory PaymentDetails.fromJson(Map<String, dynamic> json) {
//   //   return PaymentDetails(
//   //     userPaidAmount: (json['userPaidAmount'] as num).toDouble(),
//   //     driverReceivedAmount:
//   //         (json['driverReceivedAmount'] as num).toDouble(),
//   //     adminCommissionAmount:
//   //         (json['adminCommissionAmount'] as num).toDouble(),
//   //     discountAmount: (json['discountAmount'] as num).toDouble(),
//   //     originalFare: (json['originalFare'] as num).toDouble(),
//   //     promoCode: json['promoCode'],
//   //   );
//   // }

//   factory PaymentDetails.fromJson(Map<String, dynamic> json) {
//   return PaymentDetails(
//     userPaidAmount: (json['userPaidAmount'] as num?)?.toDouble() ?? 0,
//     driverReceivedAmount:
//         (json['driverReceivedAmount'] as num?)?.toDouble() ?? 0,
//     adminCommissionAmount:
//         (json['adminCommissionAmount'] as num?)?.toDouble() ?? 0,
//     discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0,
//     originalFare: (json['originalFare'] as num?)?.toDouble() ?? 0,
//     promoCode: json['promoCode'],
//   );
// }

// }

// class NearbyDriver {
//   final String id;
//   final String firstName;
//   final String lastName;

//   NearbyDriver({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//   });

//   factory NearbyDriver.fromJson(Map<String, dynamic> json) {
//     return NearbyDriver(
//       id: json['_id'],
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//     );
//   }
// }



// ride_created_response_model.dart

class RideCreatedResposeModel {
  final Ride ride;
  final List<NearbyDriver> nearbyDrivers;
  final int estimatedTime;

  RideCreatedResposeModel({
    required this.ride,
    required this.nearbyDrivers,
    required this.estimatedTime,
  });

  factory RideCreatedResposeModel.fromJson(Map<String, dynamic> json) {
    return RideCreatedResposeModel(
      ride: Ride.fromJson(json['ride']),
      nearbyDrivers: (json['nearbyDrivers'] as List? ?? [])
          .map((e) => NearbyDriver.fromJson(e))
          .toList(),
      estimatedTime: (json['estimatedTime'] as num?)?.toInt() ?? 0,
    );
  }
}

// ============================
// RIDE MODEL
// ============================

class Ride {
  final String id;
  final RideLocation pickupLocation;
  final RideLocation dropLocation;
  final PaymentDetails paymentDetails;
  final String rider;

  final double distance;
  final double finalFare;

  final String status;
  final String paymentMethod;

  // 🔥 INT fields (null-safe)
  final int estimatedTime;
  final int actualTime;
  final int cancellationPenalty;
  final int surgeMultiplier;

  final String? vehicleType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Ride({
    required this.id,
    required this.pickupLocation,
    required this.dropLocation,
    required this.paymentDetails,
    required this.rider,
    required this.distance,
    required this.finalFare,
    required this.status,
    required this.paymentMethod,
    required this.estimatedTime,
    required this.actualTime,
    required this.cancellationPenalty,
    required this.surgeMultiplier,
    this.vehicleType,
    this.createdAt,
    this.updatedAt,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['_id'] ?? '',
      pickupLocation: RideLocation.fromJson(json['pickupLocation']),
      dropLocation: RideLocation.fromJson(json['dropLocation']),
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
      rider: json['rider'] ?? '',
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      finalFare: (json['finalFare'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      estimatedTime: (json['estimatedTime'] as num?)?.toInt() ?? 0,
      actualTime: (json['actualTime'] as num?)?.toInt() ?? 0,
      cancellationPenalty:
          (json['cancellationPenalty'] as num?)?.toInt() ?? 0,
      surgeMultiplier:
          (json['surgeMultiplier'] as num?)?.toInt() ?? 1,
      vehicleType: json['vehicleType'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

// ============================
// LOCATION MODEL
// ============================

class RideLocation {
  final String address;
  final String type;
  final List<double> coordinates;

  RideLocation({
    required this.address,
    required this.type,
    required this.coordinates,
  });

  factory RideLocation.fromJson(Map<String, dynamic> json) {
    return RideLocation(
      address: json['address'] ?? '',
      type: json['type'] ?? 'Point',
      coordinates: (json['coordinates'] as List? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }
}

// ============================
// PAYMENT DETAILS
// ============================

class PaymentDetails {
  final double userPaidAmount;
  final double driverReceivedAmount;
  final double adminCommissionAmount;
  final double discountAmount;
  final double originalFare;
  final String? promoCode;

  PaymentDetails({
    required this.userPaidAmount,
    required this.driverReceivedAmount,
    required this.adminCommissionAmount,
    required this.discountAmount,
    required this.originalFare,
    this.promoCode,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      userPaidAmount: (json['userPaidAmount'] as num?)?.toDouble() ?? 0,
      driverReceivedAmount:
          (json['driverReceivedAmount'] as num?)?.toDouble() ?? 0,
      adminCommissionAmount:
          (json['adminCommissionAmount'] as num?)?.toDouble() ?? 0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0,
      originalFare: (json['originalFare'] as num?)?.toDouble() ?? 0,
      promoCode: json['promoCode'],
    );
  }
}

// ============================
// NEARBY DRIVER
// ============================

class NearbyDriver {
  final String id;
  final String firstName;
  final String lastName;

  NearbyDriver({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory NearbyDriver.fromJson(Map<String, dynamic> json) {
    return NearbyDriver(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }
}
