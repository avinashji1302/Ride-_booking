class VerifyOtpRequest {
  final String mobileOtpId;
  final String emailOtpId;
  final String otpMobile;
  final String otpEmail;
  final String deviceId;
  final String deviceType;
  final String deviceToken;

  VerifyOtpRequest({
    required this.mobileOtpId,
    required this.emailOtpId,
    required this.otpMobile,
    required this.otpEmail,
    required this.deviceId,
    required this.deviceType,
    required this.deviceToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "mobileOtpId": mobileOtpId,
      "emailOtpId": emailOtpId,
      "otpMobile": otpMobile,
      "otpEmail": otpEmail,
      "deviceId": deviceId,
      "deviceType": deviceType,
      "deviceToken": deviceToken,
    };
  }
}






// varify otp
class VarifyOtpUserResult {
  final String firstName;
  final String lastName;
  final String fullName;
  final String countryCode;
  final String mobile;
  final String email;
  final String role;
  final int isMobileVerified;
  final int isEmailVerified;
  final String profilePic;
  final String status;
  final bool isDeleted;
  final String password;
  final String? deviceId;
  final String? deviceType;
  final String? deviceToken;
  final String registrationType;
  final double? rating;
  final String? socialId;
  final bool notifications;
  final bool forceLogout;
  final int wallet;
  final int cancellationPenalty;
  final String id;
  final List<dynamic> address;
  final String createdAt;
  final String updatedAt;
  final int version;
  final String token;
  final String refreshToken;

  VarifyOtpUserResult({
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.countryCode,
    required this.mobile,
    required this.email,
    required this.role,
    required this.isMobileVerified,
    required this.isEmailVerified,
    required this.profilePic,
    required this.status,
    required this.isDeleted,
    required this.password,
    this.deviceId,
    this.deviceType,
    this.deviceToken,
    required this.registrationType,
    this.rating,
    this.socialId,
    required this.notifications,
    required this.forceLogout,
    required this.wallet,
    required this.cancellationPenalty,
    required this.id,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.token,
    required this.refreshToken,
  });

  factory VarifyOtpUserResult.fromJson(Map<String, dynamic> json) {
    return VarifyOtpUserResult(
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      countryCode: json['countryCode'],
      mobile: json['mobile'],
      email: json['email'],
      role: json['role'],
      isMobileVerified: json['isMobileVerified'],
      isEmailVerified: json['isEmailVerified'],
      profilePic: json['profilePic'] ?? "",
      status: json['status'],
      isDeleted: json['isDeleted'],
      password: json['password'],
      deviceId: json['deviceId'],
      deviceType: json['deviceType'],
      deviceToken: json['deviceToken'],
      registrationType: json['registrationType'],
      rating: json['rating']?.toDouble(),
      socialId: json['socialId'],
      notifications: json['notifications'],
      forceLogout: json['forceLogout'],
      wallet: json['wallet'],
      cancellationPenalty: json['cancellationPenalty'],
      id: json['_id'],
      address: json['address'] ?? [],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
      token: json['token'] ?? "",
      refreshToken: json['refreshToken'],
    );
  }
}

