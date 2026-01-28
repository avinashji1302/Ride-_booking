class UserProfileModle {
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
  final String? deviceId;
  final String? deviceType;
  final String? deviceToken;
  final String registrationType;
  final double? rating;
  final String? socialId;
  final bool notifications;
  final bool forceLogout;
  final double wallet;
  final double cancellationPenalty;
  final List<dynamic> address;
  final List<dynamic> savedAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? token;

  UserProfileModle({
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
    required this.deviceId,
    required this.deviceType,
    required this.deviceToken,
    required this.registrationType,
    required this.rating,
    required this.socialId,
    required this.notifications,
    required this.forceLogout,
    required this.wallet,
    required this.cancellationPenalty,
    required this.address,
    required this.savedAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });

  factory UserProfileModle.fromJson(Map<String, dynamic> json) {
    return UserProfileModle(
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
      deviceId: json['deviceId'],
      deviceType: json['deviceType'],
      deviceToken: json['deviceToken'],
      registrationType: json['registrationType'] ?? '',
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      socialId: json['socialId'],
      notifications: json['notifications'] ?? false,
      forceLogout: json['forceLogout'] ?? false,
      wallet: (json['wallet'] as num?)?.toDouble() ?? 0.0,
      cancellationPenalty:
          (json['cancellationPenalty'] as num?)?.toDouble() ?? 0.0,
      address: List<dynamic>.from(json['address'] ?? []),
      savedAddress: List<dynamic>.from(json['savedAddress'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      token: json['token'],
    );
  }
}
