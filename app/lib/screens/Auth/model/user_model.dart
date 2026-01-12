

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String mobile;
  final String countryCode;
  final bool isMobileVerified;
  final bool isEmailVerified;
  final String status;
  final String profilePic;
  final String mobileOtpId;
  final String emailOtpId;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.countryCode,
    required this.isMobileVerified,
    required this.isEmailVerified,
    required this.status,
    required this.profilePic,
    required this.mobileOtpId,
    required this.emailOtpId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      fullName: json["fullName"],
      email: json["email"],
      mobile: json["mobile"],
      countryCode: json["countryCode"],
      isMobileVerified: json["isMobileVerified"] == 1,
      isEmailVerified: json["isEmailVerified"] == 1,
      status: json["status"],
      profilePic: json["profilePic"] ?? "",
      mobileOtpId: json["mobileOtpId"],
      emailOtpId: json["emailOtpId"],
    );
  }
}
