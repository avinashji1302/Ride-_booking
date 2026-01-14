import 'package:app/config/device/device_details.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/Auth/model/signin_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final AuthStorage _storage = AuthStorage();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
 bool loading = false;
 String? error;


  Future<ApiResponse> signIn(  bool isPhone) async {
   
    loading = true;
    error = null;
    notifyListeners();

    try {
       final deviceId = await DeviceDetails.getDeviceId();
      final response = await _authRepository.signIn(
        LoginRequest(
          type: isPhone? "mobile":"email",
          email: emailController.text,
          mobile: emailController.text,
          countryCode: "+91",
          password: passController.text,
          deviceId: deviceId,
          deviceType: "android",
          deviceToken: "",
        ),
      );

      loading = false;
      notifyListeners();

        if (response.success && response.data != null) {
        await _storage.saveSession(
          accessToken: response.data!.token,
          refreshToken: response.data!.refreshToken,
        );

        emailController.clear();
        passController.clear();

        return ApiResponse(
          success: true,
          message: response.message,
        );
      }

      return ApiResponse(
        success: false,
        message: response.message,
        data: response.data
      );
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Something went wrong",
      );
    }
  }


    @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
 