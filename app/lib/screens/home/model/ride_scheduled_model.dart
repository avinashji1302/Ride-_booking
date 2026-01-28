

class RideScheduledModel {
  final String id;
  final Location pickupLocation;
  final Location dropLocation;
  final PaymentDetails paymentDetails;

  final String? driver;
  final String rider;

  final double distance;
  final List<dynamic> estimatedFare;
  final double finalFare;
  final double originalFare;
  final double discountAmount;
  final double cancellationPenalty;
  final int surgeMultiplier;

  final String paymentMethod;
  final String status;

  final bool isScheduled;
  final DateTime? scheduledFor;
  final DateTime? scheduledAt;

  final bool reminderSent;
  final bool autoCancelled;

  final String cancellationReason;
  final String? cancelledBy;
  final DateTime? cancelledAt;
  final List<dynamic> cancelledDrivers;

  final int? otpForRideStart;

  final DateTime? startedAt;
  final DateTime? completedAt;
  final int estimatedTime;
  final int actualTime;
  final DateTime? actualArrivalTime;
  final DateTime? actualCompletionTime;

  final bool paidToDriver;
  final bool paidToAdmin;
  final bool paymentSuccessful;
  final bool cashPaidByUser;

  final String? transactionId;
  final String? promoCode;
  final String vehicleType;

  final DateTime createdAt;
  final DateTime updatedAt;

  RideScheduledModel({
    required this.id,
    required this.pickupLocation,
    required this.dropLocation,
    required this.paymentDetails,
    required this.driver,
    required this.rider,
    required this.distance,
    required this.estimatedFare,
    required this.finalFare,
    required this.originalFare,
    required this.discountAmount,
    required this.cancellationPenalty,
    required this.surgeMultiplier,
    required this.paymentMethod,
    required this.status,
    required this.isScheduled,
    required this.scheduledFor,
    required this.scheduledAt,
    required this.reminderSent,
    required this.autoCancelled,
    required this.cancellationReason,
    required this.cancelledBy,
    required this.cancelledAt,
    required this.cancelledDrivers,
    required this.otpForRideStart,
    required this.startedAt,
    required this.completedAt,
    required this.estimatedTime,
    required this.actualTime,
    required this.actualArrivalTime,
    required this.actualCompletionTime,
    required this.paidToDriver,
    required this.paidToAdmin,
    required this.paymentSuccessful,
    required this.cashPaidByUser,
    required this.transactionId,
    required this.promoCode,
    required this.vehicleType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RideScheduledModel.fromJson(Map<String, dynamic> json) {
    return RideScheduledModel(
      id: json['_id'],
      pickupLocation: Location.fromJson(json['pickupLocation']),
      dropLocation: Location.fromJson(json['dropLocation']),
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
      driver: json['driver'],
      rider: json['rider'],
      distance: (json['distance'] ?? 0).toDouble(),
      estimatedFare: json['estimatedFare'] ?? [],
      finalFare: (json['finalFare'] ?? 0).toDouble(),
      originalFare: (json['originalFare'] ?? 0).toDouble(),
      discountAmount: (json['discountAmount'] ?? 0).toDouble(),
      cancellationPenalty: (json['cancellationPenalty'] ?? 0).toDouble(),
      surgeMultiplier: json['surgeMultiplier'] ?? 1,
      paymentMethod: json['paymentMethod'],
      status: json['status'],
      isScheduled: json['isScheduled'],
      scheduledFor: json['scheduledFor'] != null
          ? DateTime.parse(json['scheduledFor'])
          : null,
      scheduledAt: json['scheduledAt'] != null
          ? DateTime.parse(json['scheduledAt'])
          : null,
      reminderSent: json['reminderSent'],
      autoCancelled: json['autoCancelled'],
      cancellationReason: json['cancellationReason'] ?? '',
      cancelledBy: json['cancelledBy'],
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'])
          : null,
      cancelledDrivers: json['cancelledDrivers'] ?? [],
      otpForRideStart: json['otpForRideStart'],
      startedAt:
          json['startedAt'] != null ? DateTime.parse(json['startedAt']) : null,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      estimatedTime: json['estimatedTime'] ?? 0,
      actualTime: json['actualTime'] ?? 0,
      actualArrivalTime: json['actualArrivalTime'] != null
          ? DateTime.parse(json['actualArrivalTime'])
          : null,
      actualCompletionTime: json['actualCompletionTime'] != null
          ? DateTime.parse(json['actualCompletionTime'])
          : null,
      paidToDriver: json['paidToDriver'],
      paidToAdmin: json['paidToAdmin'],
      paymentSuccessful: json['paymentSuccessful'],
      cashPaidByUser: json['cashPaidByUser'],
      transactionId: json['transactionId'],
      promoCode: json['promoCode'],
      vehicleType: json['vehicleType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Location {
  final String type;
  final List<double> coordinates;
  final String address;

  Location({
    required this.type,
    required this.coordinates,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates:
          List<double>.from(json['coordinates'].map((e) => e.toDouble())),
      address: json['address'] ?? '',
    );
  }
}

class PaymentDetails {
  final double userPaidAmount;
  final double driverReceivedAmount;
  final double adminCommissionAmount;
  final DateTime? paymentCompletedAt;
  final double discountAmount;
  final double originalFare;
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
      userPaidAmount: (json['userPaidAmount'] ?? 0).toDouble(),
      driverReceivedAmount:
          (json['driverReceivedAmount'] ?? 0).toDouble(),
      adminCommissionAmount:
          (json['adminCommissionAmount'] ?? 0).toDouble(),
      paymentCompletedAt: json['paymentCompletedAt'] != null
          ? DateTime.parse(json['paymentCompletedAt'])
          : null,
      discountAmount: (json['discountAmount'] ?? 0).toDouble(),
      originalFare: (json['originalFare'] ?? 0).toDouble(),
      promoCode: json['promoCode'],
    );
  }
}
