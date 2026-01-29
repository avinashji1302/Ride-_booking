class GetDuePaymentModel {
  final String rideId;
  final String amountToPay;
  final String currency;

  GetDuePaymentModel({
    required this.rideId,
    required this.amountToPay,
    required this.currency,
  });

  factory GetDuePaymentModel.fromJson(Map<String, dynamic> json) {
    return GetDuePaymentModel(
      rideId: json['rideId'],
      amountToPay: (json['amountToPay']).toString(),
      currency: json['currency'],
    );
  }
}