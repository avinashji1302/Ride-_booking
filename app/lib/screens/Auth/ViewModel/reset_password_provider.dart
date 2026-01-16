import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/Auth/model/reset_password_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class ResetPasswordProvider extends ChangeNotifier {
  final AuthRepository repository = AuthRepository();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  bool loading = false;
  String? error;

  Future<ApiResponse> resetPassword(String email) async {
    loading = true;
    notifyListeners();
    try {
      final response = await repository.resetPassword(
        ResetPasswordModel(
          email: email,
          newPassword: newPassword.text.trim(),
          confirmPassword: confirmPassword.text.trim(),
        ),
      );

      debugPrint("email is $email");
      loading = false;
      notifyListeners();

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();

      return ApiResponse(success: false, message: "OTP verification failed");
    }
  }
}
