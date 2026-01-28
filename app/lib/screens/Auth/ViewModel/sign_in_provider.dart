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
    text: "avinash",
  );

   final TextEditingController phoneController = TextEditingController(
    text: "avinash",
  );
  bool loading = false;
  String? error;

  SignInResponse? _userDetails;

    SignInResponse? get  userDetails=>_userDetails;

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

      debugPrint("data : $isPhone ${phoneController.text} ${response.message}}");

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
        
        SocketService().connect( token!, userId!);

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

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
