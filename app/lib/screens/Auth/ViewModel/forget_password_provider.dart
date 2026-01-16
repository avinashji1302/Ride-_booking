import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/Auth/model/forget_passowrd_model.dart';
import 'package:app/screens/Auth/model/reset_password_model.dart';
import 'package:app/screens/Auth/model/varifty_user_forget_password_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  final AuthRepository repository = AuthRepository();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool loading = false;
  ForgetPassowrdModel? _authResult;
  String? error;

  ForgetPassowrdModel? get authResult => _authResult;


  /// SEND OTP
  Future<ApiResponse> forgetPassword() async {
    loading = true;
    notifyListeners();

    try {
      final response = await repository.forgetPassword(
        ForgetPassowrdModelRequest(
          email: emailController.text.trim(),
          type: "email",
        ),
      );

      loading = false;
      notifyListeners();

      if (!response.success || response.data == null) {
        return ApiResponse(success: false, message: response.message);
      }

      _authResult = response.data;

      debugPrint("message : ${authResult!.otp}");

      return ApiResponse(
        success: true,
        message: response.message,
        data: response.data,
      );
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();

      return ApiResponse(success: false, message: "Failed to send OTP ${e.toString()}");
    }
  }

  /// VERIFY OTP
  Future<ApiResponse> verifyForgetPasswordOtp() async {
    if (authResult == null) {
      return ApiResponse(success: false, message: "Please request OTP first");
    }

    print("inside:: ");

    loading = true;
    notifyListeners();

    try {
      final response = await repository.variftForgetPasswordOtp(
        VariftyUserForgetPasswordModel(
          type: 'email',
          otpId: authResult!.id,
          email: authResult!.email,
          otp: authResult!.otp.toString(),
        ),
      );

      print(
        "inside::  ${response.message} ${authResult!.otp}. ${authResult!.id} ${authResult!.email}",
      );

      loading = false;
      notifyListeners();

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();

      return ApiResponse(success: false, message: "OTP verification failed ${e.toString()}");
    }
  }

  

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }
}
