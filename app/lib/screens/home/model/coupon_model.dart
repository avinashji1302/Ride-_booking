class CouponModel {
  final Discount? discount;
  final String? userId;
  final String? rideId;

  CouponModel({
    this.discount,
    this.userId,
    this.rideId,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      discount: json['discount'] != null
          ? Discount.fromJson(json['discount'])
          : null,
      userId: json['userId'],
      rideId: json['rideId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'discount': discount?.toJson(),
      'userId': userId,
      'rideId': rideId,
    };
  }
}

class Discount {
  final String? discountType; // percentage | flat
  final int? discountValue;
  final int? maxDiscountValue;
  final String? code;

  Discount({
    this.discountType,
    this.discountValue,
    this.maxDiscountValue,
    this.code,
  });

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      discountType: json['discountType'],
      discountValue: json['discountValue'],
      maxDiscountValue: json['maxDiscountValue'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'discountType': discountType,
      'discountValue': discountValue,
      'maxDiscountValue': maxDiscountValue,
      'code': code,
    };
  }}