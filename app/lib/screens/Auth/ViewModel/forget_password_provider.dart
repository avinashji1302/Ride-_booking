import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/Auth/model/forget_passowrd_model.dart';
import 'package:app/screens/Auth/model/varifty_user_forget_password_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  final AuthRepository repository = AuthRepository();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool loading = false;
  ForgetPassowrdModel? authResult;
  String? error;

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
        return ApiResponse(
          success: false,
          message: response.message,
        );
      }

      authResult = response.data;

      return ApiResponse(
        success: true,
        message: response.message,
        data: response.data,
      );
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Failed to send OTP",
      );
    }
  }

  /// VERIFY OTP
  Future<ApiResponse> verifyForgetPasswordOtp() async {
    if (authResult == null) {
      return ApiResponse(
        success: false,
        message: "Please request OTP first",
      );
    }

    loading = true;
    notifyListeners();

    try {
      final response = await repository.variftForgetPasswordOtp(
        VariftyUserForgetPasswordModel(
          type: 'email',
          otpId: authResult!.id,
          email: authResult!.email,
          otp: otpController.text.trim(),
        ),
      );

      loading = false;
      notifyListeners();

      return ApiResponse(
        success: response.success,
        message: response.message,
      );
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "OTP verification failed",
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }
}
