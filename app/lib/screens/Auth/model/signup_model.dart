import 'package:app/screens/Auth/model/user_model.dart';

class SignupModel {
  final String fullName;
  final String email;
  final String mobile;
  final String countryCode;
  final String password;

  SignupModel({
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.countryCode,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "mobile": mobile,
      "countryCode": countryCode,
      "password": password,
    };
  }
}

// ---------------- RESPONSE ----------------

class SignUpResponse {
  final bool success;
  final String message;
  final UserModel user;
  

  SignUpResponse({
    required this.success,
    required this.message, required this.user,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      success: json["success"],
      message: json["message"], user: UserModel.fromJson(json["results"]),
    );
  }
}
