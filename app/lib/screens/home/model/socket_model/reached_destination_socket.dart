// ride_model.dart

class ReachedDestinationSocket {
  final String id;
  final Location pickupLocation;
  final Location dropLocation;
  final PaymentDetails paymentDetails;
  final String driverId;
  final String riderId;
  final String distance;
  final String finalFare;
  final String originalFare;
  final String discountAmount;
  final String cancellationPenalty;
  final String surgeMultiplier;
  final String paymentMethod;
  final String status;
  final String isScheduled;
  final String? startedAt;
  final String? completedAt;
  final String estimatedTime;
  final String actualTime;
  final String paidToDriver;

  ReachedDestinationSocket({
    required this.id,
    required this.pickupLocation,
    required this.dropLocation,
    required this.paymentDetails,
    required this.driverId,
    required this.riderId,
    required this.distance,
    required this.finalFare,
    required this.originalFare,
    required this.discountAmount,
    required this.cancellationPenalty,
    required this.surgeMultiplier,
    required this.paymentMethod,
    required this.status,
    required this.isScheduled,
    required this.startedAt,
    required this.completedAt,
    required this.estimatedTime,
    required this.actualTime,
    required this.paidToDriver,
  });

  factory ReachedDestinationSocket.fromJson(Map<String, dynamic> json) {
    return ReachedDestinationSocket(
      id: json['_id']?.toString() ?? '',
      pickupLocation: Location.fromJson(json['pickupLocation']),
      dropLocation: Location.fromJson(json['dropLocation']),
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
      driverId: json['driver']?.toString() ?? '',
      riderId: json['rider']?.toString() ?? '',
      distance: json['distance']?.toString() ?? '0',
      finalFare: json['finalFare']?.toString() ?? '0',
      originalFare: json['originalFare']?.toString() ?? '0',
      discountAmount: json['discountAmount']?.toString() ?? '0',
      cancellationPenalty: json['cancellationPenalty']?.toString() ?? '0',
      surgeMultiplier: json['surgeMultiplier']?.toString() ?? '1',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      isScheduled: json['isScheduled']?.toString() ?? 'false',
      startedAt: json['startedAt']?.toString(),
      completedAt: json['completedAt']?.toString(),
      estimatedTime: json['estimatedTime']?.toString() ?? '0',
      actualTime: json['actualTime']?.toString() ?? '0',
      paidToDriver: json['paidToDriver']?.toString() ?? 'false',
    );
  }
}

// ----------------------- Location -----------------------

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
    return Location(
      type: json['type']?.toString() ?? '',
      latitude: json['coordinates']?[0]?.toString() ?? '0',
      longitude: json['coordinates']?[1]?.toString() ?? '0',
      address: json['address']?.toString() ?? '',
    );
  }
}

// ----------------------- Payment Details -----------------------

class PaymentDetails {
  final String userPaidAmount;
  final String driverReceivedAmount;
  final String adminCommissionAmount;
  final String? paymentCompletedAt;
  final String discountAmount;
  final String originalFare;
  final String? promoCode;

  PaymentDetails({
    required this.userPaidAmount,
    required this.driverReceivedAmount,
    required this.adminCommissionAmount,
    required this.paymentCompletedAt,
    required this.discountAmount,
    required this.originalFare,
    required this.promoCode,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      userPaidAmount: json['userPaidAmount']?.toString() ?? '0',
      driverReceivedAmount:
          json['driverReceivedAmount']?.toString() ?? '0',
      adminCommissionAmount:
          json['adminCommissionAmount']?.toString() ?? '0',
      paymentCompletedAt: json['paymentCompletedAt']?.toString(),
      discountAmount: json['discountAmount']?.toString() ?? '0',
      originalFare: json['originalFare']?.toString() ?? '0',
      promoCode: json['promoCode']?.toString(),
    );
  }
}
