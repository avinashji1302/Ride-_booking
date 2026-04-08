import 'package:app/config/Socket/socket.dart';
import 'package:app/config/device/device_details.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/Auth/model/signin_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final AuthStorage _storage = AuthStorage();
  final TextEditingController emailController = TextEditingController(
    text: "avinash@gmail.com",
  );
  final TextEditingController passController = TextEditingController(
    text: "password123456",
  );

  final TextEditingController phoneController = TextEditingController(
    text: "avinash",
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  bool loading = false;
  String? error;

  SignInResponse? _userDetails;

  SignInResponse? get userDetails => _userDetails;

  Future<ApiResponse> signIn(BuildContext context, bool isPhone) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final deviceId = await DeviceDetails.getDeviceId();
      final response = await _authRepository.signIn(
        LoginRequest(
          type: isPhone ? "mobile" : "email",
          email: emailController.text,
          mobile: phoneController.text,
          countryCode: "+91",
          password: passController.text,
          deviceId: deviceId,
          deviceType: "android",
          deviceToken: "",
        ),
      );

      loading = false;
      notifyListeners();

      debugPrint(
        "data : $isPhone ${phoneController.text} ${response.message}}",
      );

      if (response.success && response.data != null) {
        await _storage.saveSession(
          accessToken: response.data!.token,
          refreshToken: response.data!.refreshToken,
        );
        await AuthStorage().saveUserId(response.data!.id);
        final userId = await AuthStorage().getUserId();
        //  final id = response.data!.id;

        _userDetails = response.data;
        emailController.clear();
        passController.clear();

        debugPrint("data : ${response.data!.id}");
        final token = await AuthStorage().getAccessToken();

        SocketService().connect(token!, userId!);

        return ApiResponse(success: true, message: response.message);
      }

      debugPrint("errror : ${response.message} ${response.success}");

      return ApiResponse(
        success: false,
        message: response.message,
        data: response.data,
      );
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();
      debugPrint("somethign : $e");
      return ApiResponse(success: false, message: "Something went wrong $e");
    }
  }

  //------------------------------Signin with OTP---------------------------------

  final TextEditingController inputController = TextEditingController();
  final TextEditingController varifyLoginOtp = TextEditingController(
    text: "1234",
  );

  /// STORE FOR NEXT API
  String? emailOtpId;
  String? mobileOtpId;

  bool get isPhone =>
      RegExp(r'^[0-9]{10}$').hasMatch(inputController.text.trim());

  Future<ApiResponse> signInWithOtp(BuildContext context) async {
    if (!otpFormKey.currentState!.validate()) {
      return ApiResponse(success: false, message: "Invalid Input");
    }

    debugPrint("Tapped send Otp");

    loading = true;
    notifyListeners();

    try {
      final body = isPhone
          ? {"mobile": inputController.text.trim(), "countryCode": "+91"}
          : {"email": inputController.text.trim()};

      final response = await _authRepository.loginWithOtp(body, isPhone);

      loading = false;
      notifyListeners();
      debugPrint("response : $response  $isPhone");

      if (response.success && response.data != null) {
        // / 🔥 STORE OTP ID
        if (isPhone) {
          mobileOtpId = response.data!.mobileOtpId;
          debugPrint("phone : $emailOtpId ${response.data!.emailOtpId} ");
        } else {
          emailOtpId = response.data!.emailOtpId;

          debugPrint("email : $emailOtpId ${response.data!.emailOtpId} ");
        }

        debugPrint("Tapped send Otp $body $mobileOtpId $emailOtpId");

        return ApiResponse(success: true, message: response.message);
      }

      return ApiResponse(success: false, message: response.message);
    } catch (e) {
      loading = false;
      notifyListeners();
      return ApiResponse(success: false, message: e.toString());
    }
  }

  //--------------------------------Varify with OTP----------------------------------

  Future<ApiResponse> varidySignInWithOtp(BuildContext context) async {
    if (!otpFormKey.currentState!.validate()) {
      return ApiResponse(success: false, message: "Invalid Input");
    }

    debugPrint("Tapped send Otp");

    loading = true;
    notifyListeners();

    try {
      final deviceId = await DeviceDetails.getDeviceId();

      debugPrint("phone : $emailOtpId } ");

      final body = isPhone
          ? {
              "mobileOtpId": mobileOtpId,
              "otp": "1234",
              "deviceId": deviceId,
              "deviceType": "android",
              "deviceToken": "",
            }
          : {
              "emailOtpId": emailOtpId,
              "otp": "1234",
              "deviceId": deviceId,
              "deviceType": "android",
              "deviceToken": "",
            };

      final response = await _authRepository.varifyLoginWithOtp(body, isPhone);

      debugPrint("phone : $emailOtpId ${response.data!} ");

      loading = false;
      notifyListeners();

      if (response.success && response.data != null) {
        await _storage.saveSession(
          accessToken: response.data!.token,
          refreshToken: response.data!.refreshToken,
        );
        await AuthStorage().saveUserId(response.data!.id);
        final userId = await AuthStorage().getUserId();
        //  final id = response.data!.id;

        _userDetails = response.data;

        debugPrint("data : ${response.data!.id}");
        final token = await AuthStorage().getAccessToken();

        SocketService().connect(token!, userId!);

        // / 🔥 STORE OTP ID
        inputController.clear();
        varifyLoginOtp.clear();

        return ApiResponse(success: true, message: response.message);
      }

      return ApiResponse(success: false, message: response.message);
    } catch (e) {
      loading = false;
      notifyListeners();
      return ApiResponse(success: false, message: e.toString());
    }
  }



//----------------------------------------Resend OTP again -------------------------------------------------------------

 Future<ApiResponse> reSendOTP(BuildContext context) async {
    if (!otpFormKey.currentState!.validate()) {
      return ApiResponse(success: false, message: "Invalid Input");
    }

    debugPrint("Tapped Resend send Otp");

    loading = true;
    notifyListeners();

    try {
      final body = isPhone
          ? {"mobile": inputController.text.trim(), "countryCode": "+91"}
          : {"email": inputController.text.trim()};

      final response = await _authRepository.resendOtp(body, isPhone);

      loading = false;
      notifyListeners();
      debugPrint("response : $response  $isPhone");

      if (response.success && response.data != null) {
        // / 🔥 STORE OTP ID
        if (isPhone) {
          mobileOtpId = response.data!.mobileOtpId;
          debugPrint("phone : $emailOtpId ${response.data!.emailOtpId} ");
        } else {
          emailOtpId = response.data!.emailOtpId;

          debugPrint("email : $emailOtpId ${response.data!.emailOtpId} ");
        }

        debugPrint("Tapped send Otp $body $mobileOtpId $emailOtpId");

        return ApiResponse(success: true, message: response.message);
      }

      return ApiResponse(success: false, message: response.message);
    } catch (e) {
      loading = false;
      notifyListeners();
      return ApiResponse(success: false, message: e.toString());
    }
  }


  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    inputController.dispose();
    varifyLoginOtp.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
