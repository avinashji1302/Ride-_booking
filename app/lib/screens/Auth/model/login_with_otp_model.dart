import 'package:flutter/material.dart';

class LoginWithOtpModel {
  String? mobileOtpId;
  String? emailOtpId;

  LoginWithOtpModel({this.mobileOtpId, this.emailOtpId});

  factory LoginWithOtpModel.fromJson(Map<String, dynamic> json) {
    debugPrint("json is : $json");

    final results = json;
    debugPrint("results is : $results");

    return LoginWithOtpModel(
      mobileOtpId: results['mobileOtpId'] ?? "",
      emailOtpId: results['emailOtpId'] ?? "",
    );
  }
}
