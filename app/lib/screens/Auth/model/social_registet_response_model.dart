import 'package:flutter/cupertino.dart';

class SocialRegistetResponseModel {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String? countryCode;
  final String email;
  final String role;

  final bool isMobileVerified;
  final bool isEmailVerified;

  final String status;
  final bool isDeleted;

  final String deviceId;
  final String deviceType;
  final String deviceToken;

  final String registrationType;
  final String? socialId;

  final bool notifications;
  final bool forceLogout;

  final int wallet;
  final int cancellationPenalty;

  final List<dynamic> address;

  final String createdAt;
  final String updatedAt;

  final String profilePic;

  final String token;
  final String refreshToken;

  SocialRegistetResponseModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    this.countryCode,
    required this.email,
    required this.role,
    required this.isMobileVerified,
    required this.isEmailVerified,
    required this.status,
    required this.isDeleted,
    required this.deviceId,
    required this.deviceType,
    required this.deviceToken,
    required this.registrationType,
    this.socialId,
    required this.notifications,
    required this.forceLogout,
    required this.wallet,
    required this.cancellationPenalty,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePic,
    required this.token,
    required this.refreshToken,
  });

  factory SocialRegistetResponseModel.fromJson(Map<String, dynamic> json) {

   
    final data = json ?? {};
 debugPrint("json :....... $data");


    return SocialRegistetResponseModel(
      id: data['_id'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      fullName: data['fullName'] ?? '',
      countryCode: data['countryCode'],
      email: data['email'] ?? '',
      role: data['role'] ?? '',

      isMobileVerified: data['isMobileVerified'] == 1,
      isEmailVerified: data['isEmailVerified'] == 1,

      status: data['status'] ?? '',
      isDeleted: data['isDeleted'] ?? false,

      deviceId: data['deviceId'] ?? '',
      deviceType: data['deviceType'] ?? '',
      deviceToken: data['deviceToken'] ?? '',

      registrationType: data['registrationType'] ?? '',
      socialId: data['socialId'],

      notifications: data['notifications'] ?? false,
      forceLogout: data['forceLogout'] ?? false,

      wallet: data['wallet'] ?? 0,
      cancellationPenalty: data['cancellationPenalty'] ?? 0,

      address: data['address'] ?? [],

      createdAt: data['createdAt'] ?? '',
      updatedAt: data['updatedAt'] ?? '',

      profilePic: data['profilePic'] ?? '',

      token: data['token'] ?? '',
      refreshToken: data['refreshToken'] ?? '',
    );
  }
}