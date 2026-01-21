class LoginRequest {
  final String type;
  final String? email;
  final String? mobile;
    final String? countryCode;
  final String password;
  final String deviceId;
  final String deviceType;
  final String deviceToken;

  LoginRequest({
    required this.type,
    required this.email,
    required this.password,
    required this.deviceId,
    required this.deviceType,
    required this.deviceToken, this.mobile, this.countryCode,
  });

  /// Convert JSON → Model
  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      type: json['type'] ?? '',
      email: json['email'] ?? '',
       mobile: json['mobile'] ?? '',
        countryCode: json['countryCode'] ?? '',
      password: json['password'] ?? '',
      deviceId: json['deviceId'] ?? '',
      deviceType: json['deviceType'] ?? '',
      deviceToken: json['deviceToken'] ?? '',
      

    );
  }

  /// Convert Model → JSON
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "email": email,
      "mobile":mobile,
      "countryCode":countryCode,
      "password": password,
      "deviceId": deviceId,
      "deviceType": deviceType,
      "deviceToken": deviceToken,
    };
  }

}

// ------------response -----------------------

class SignInResponse {
  final String id;
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
  final String registrationType;
  final bool notifications;
  final bool forceLogout;
  final String wallet;
  final String cancellationPenalty;
  final List<dynamic> address;
  final String createdAt;
  final String updatedAt;
  final String token;
  final String refreshToken;

  SignInResponse({
    required this.id,
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
    required this.registrationType,
    required this.notifications,
    required this.forceLogout,
    required this.wallet,
    required this.cancellationPenalty,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
    required this.refreshToken,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
      countryCode: json['countryCode'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isMobileVerified: json['isMobileVerified'] ?? 0,
      isEmailVerified: json['isEmailVerified'] ?? 0,
      profilePic: json['profilePic'] ?? '',
      status: json['status'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      registrationType: json['registrationType'] ?? '',
      notifications: json['notifications'] ?? false,
      forceLogout: json['forceLogout'] ?? false,
      wallet: json['wallet']?.toString() ?? '0',
    cancellationPenalty: json['cancellationPenalty']?.toString() ?? '0',
      address: json['address'] ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}
