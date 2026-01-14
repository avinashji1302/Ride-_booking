import 'package:app/config/device/device_details.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/Auth/model/otp_varify_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class SignUpPhoneVarificationProvider extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();
  final AuthStorage _storage = AuthStorage();

  final TextEditingController otpMobile = TextEditingController();

  bool loading = false;
  String? error;

  Future<ApiResponse> verifyOtp({
    required String mobileOtpId,
    required String emailOtpId,
  }) async {
    final deviceId = await DeviceDetails.getDeviceId();

    loading = true;
    error = null;
    notifyListeners();

    try {
      final response = await _repo.verifySignUpOtp(
        VerifyOtpRequest(
          deviceId: deviceId,
          mobileOtpId: mobileOtpId,
          emailOtpId: emailOtpId,
          otpMobile: otpMobile.text.trim(),
          otpEmail: otpMobile.text.trim(),
          deviceType: 'android',
          deviceToken: '',
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

      final authResult = response.data!;

      await _storage.saveSession(
        accessToken: authResult.token,
        refreshToken: authResult.refreshToken,
      );

      return ApiResponse(
        success: true,
        message: response.message,
        data: authResult,
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
    otpMobile.dispose();
    super.dispose();
  }
}
