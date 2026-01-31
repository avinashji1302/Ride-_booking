class OlaPaymentStatusHistory {
  final Meta meta;
  final List<PaymentData> data;

  OlaPaymentStatusHistory({
    required this.meta,
    required this.data,
  });

  factory OlaPaymentStatusHistory.fromJson(Map<String, dynamic> json) {
    return OlaPaymentStatusHistory(
      meta: Meta.fromJson(json['meta']),
      data: List<PaymentData>.from(
        json['data'].map((x) => PaymentData.fromJson(x)),
      ),
    );
  }
}

class Meta {
  final int total;
  final int page;
  final int pageSize;

  Meta({
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      page: json['page'],
      pageSize: json['pageSize'],
    );
  }
}

class PaymentData {
  final String id;
  final String paymentMethod;
  final PaymentDetails paymentDetails;
  final num amount;
  final num totalAmount;
  final String currency;
  final String status;
  final String transactionId;
  final DateTime createdAt;

  PaymentData({
    required this.id,
    required this.paymentMethod,
    required this.paymentDetails,
    required this.amount,
    required this.totalAmount,
    required this.currency,
    required this.status,
    required this.transactionId,
    required this.createdAt,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      id: json['_id'],
      paymentMethod: json['paymentMethod'],
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails']),
      amount: json['amount'],
      totalAmount: json['totalAmount'],
      currency: json['currency'],
      status: json['status'],
      transactionId: json['transactionId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class PaymentDetails {
  final String? upiId;
  final String? upiTransactionId;
  final String? notes;
  final String? bankTransactionId;
  final String? transferDate;

  PaymentDetails({
    this.upiId,
    this.upiTransactionId,
    this.notes,
    this.bankTransactionId,
    this.transferDate,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      upiId: json['upiId'],
      upiTransactionId: json['upiTransactionId'],
      notes: json['notes'],
      bankTransactionId: json['bankTransactionId'],
      transferDate: json['transferDate'],
    );
  }
}
