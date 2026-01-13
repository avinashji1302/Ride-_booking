
//forget password request model
class ForgetPassowrdModelRequest {
  final String type;
  final String email; // "mobile" or "email"
  // final String? otpId;
  // final String? mobile;
  // final String countryCode;
  // final String otp;

  ForgetPassowrdModelRequest({
    required this.type,
        required this.email,
    // required this.otpId,
    // required this.mobile,
    // required this.countryCode,
    // required this.otp,

  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "email": email,
      // "otpId": otpId,
      // "mobile": mobile,
      // "countryCode": countryCode,
      // "otp": otp,
    };
  }
}





// forget password response model
class ForgetPassowrdModel {
  final String? mobile;
  final String? countryCode;
  final String email;
  final int otp;
  final String id;
  final String createdAt;
  final String updatedAt;

  ForgetPassowrdModel({
    this.mobile,
    this.countryCode,
    required this.email,
    required this.otp,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ForgetPassowrdModel.fromJson(Map<String, dynamic> json) {
    return ForgetPassowrdModel(
      mobile: json['mobile'],
      countryCode: json['countryCode'],
      email: json['email'] ?? '',
      otp: json['otp'] ?? 0,
      id: json['_id'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mobile": mobile,
      "countryCode": countryCode,
      "email": email,
      "otp": otp,
      "_id": id,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}



