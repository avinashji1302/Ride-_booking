class TransactionData {
  final List<String> rideIds;
  final String paidBy;
  final String paidTo;
  final String paidById;
  final String paidToId;
  final String paymentMethod;
  final PaymentDetails paymentDetails;
  final String transactionType;
  final double amount;
  final double commissionAmount;
  final double totalAmount;
  final String currency;
  final String status;
  final double transactionAmount;
  final double vatAmount;
  final double discountedPrice;
  final double adminCommission;
  final double supplierCommission;
  final String? type;
  final String? paymentType;
  final String userId;
  final String? supplierId;
  final String? driverId;
  final String? orderObjectId;
  final String? orderId;
  final bool isCancelled;
  final String id;
  final String transactionId;
  final DateTime createdAt;
  final DateTime updatedAt;

  TransactionData({
    required this.rideIds,
    required this.paidBy,
    required this.paidTo,
    required this.paidById,
    required this.paidToId,
    required this.paymentMethod,
    required this.paymentDetails,
    required this.transactionType,
    required this.amount,
    required this.commissionAmount,
    required this.totalAmount,
    required this.currency,
    required this.status,
    required this.transactionAmount,
    required this.vatAmount,
    required this.discountedPrice,
    required this.adminCommission,
    required this.supplierCommission,
    required this.type,
    required this.paymentType,
    required this.userId,
    required this.supplierId,
    required this.driverId,
    required this.orderObjectId,
    required this.orderId,
    required this.isCancelled,
    required this.id,
    required this.transactionId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      rideIds: List<String>.from(json['rideIds'] ?? []),
      paidBy: json['paidBy'] ?? '',
      paidTo: json['paidTo'] ?? '',
      paidById: json['paidById'] ?? '',
      paidToId: json['paidToId'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      paymentDetails: PaymentDetails.fromJson(json['paymentDetails'] ?? {}),
      transactionType: json['transactionType'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      commissionAmount:
          (json['commissionAmount'] as num?)?.toDouble() ?? 0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] ?? '',
      status: json['status'] ?? '',
      transactionAmount:
          (json['transactionAmount'] as num?)?.toDouble() ?? 0,
      vatAmount: (json['VATAmount'] as num?)?.toDouble() ?? 0,
      discountedPrice:
          (json['discountedPrice'] as num?)?.toDouble() ?? 0,
      adminCommission:
          (json['adminCommission'] as num?)?.toDouble() ?? 0,
      supplierCommission:
          (json['supplierCommission'] as num?)?.toDouble() ?? 0,
      type: json['type'],
      paymentType: json['paymentType'],
      userId: json['userId'] ?? '',
      supplierId: json['supplierId'],
      driverId: json['driverId'],
      orderObjectId: json['orderObjectId'],
      orderId: json['orderId'],
      isCancelled: json['isCancelled'] ?? false,
      id: json['_id'] ?? '',
      transactionId: json['transactionId'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class PaymentDetails {
  final String? upiId;
  final String? upiTransactionId;
  final String? notes;
  final String? walletTransactionId;
  final String? gatewayTransactionId;
  final String? gatewayName;
  final dynamic paymentGatewayResponse;
  final String? cashReceivedBy;
  final DateTime? cashReceivedAt;
  final String? cashReceiptNumber;
  final String? chequeNumber;
  final DateTime? chequeDate;
  final String? bankTransactionId;
  final String? bankAccountNumber;
  final DateTime? transferDate;
  final String? verifiedBy;
  final DateTime? verifiedAt;
  final String? adminNotes;
  final String? cardLast4;
  final String? cardType;

  PaymentDetails({
    this.upiId,
    this.upiTransactionId,
    this.notes,
    this.walletTransactionId,
    this.gatewayTransactionId,
    this.gatewayName,
    this.paymentGatewayResponse,
    this.cashReceivedBy,
    this.cashReceivedAt,
    this.cashReceiptNumber,
    this.chequeNumber,
    this.chequeDate,
    this.bankTransactionId,
    this.bankAccountNumber,
    this.transferDate,
    this.verifiedBy,
    this.verifiedAt,
    this.adminNotes,
    this.cardLast4,
    this.cardType,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      upiId: json['upiId'],
      upiTransactionId: json['upiTransactionId'],
      notes: json['notes'],
      walletTransactionId: json['walletTransactionId'],
      gatewayTransactionId: json['gatewayTransactionId'],
      gatewayName: json['gatewayName'],
      paymentGatewayResponse: json['paymentGatewayResponse'],
      cashReceivedBy: json['cashReceivedBy'],
      cashReceivedAt: json['cashReceivedAt'] != null
          ? DateTime.parse(json['cashReceivedAt'])
          : null,
      cashReceiptNumber: json['cashReceiptNumber'],
      chequeNumber: json['chequeNumber'],
      chequeDate: json['chequeDate'] != null
          ? DateTime.parse(json['chequeDate'])
          : null,
      bankTransactionId: json['bankTransactionId'],
      bankAccountNumber: json['bankAccountNumber'],
      transferDate: json['transferDate'] != null
          ? DateTime.parse(json['transferDate'])
          : null,
      verifiedBy: json['verifiedBy'],
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'])
          : null,
      adminNotes: json['adminNotes'],
      cardLast4: json['cardLast4'],
      cardType: json['cardType'],
    );
  }
}