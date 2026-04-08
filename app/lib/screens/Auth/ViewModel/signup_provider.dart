import 'package:app/config/device/device_details.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/Auth/model/social_registet_response_model.dart';
import 'package:app/screens/Auth/model/user_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/signup_model.dart';

class SignupProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final AuthStorage _storage = AuthStorage();
  bool loading = false;

  UserModel? userDetails;

  bool isLoading = false;
  String? errorMessage;

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController countryCode = TextEditingController(text: "91");

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<ApiResponse<UserModel?>> register(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _authRepository.register(
        SignupModel(
          fullName: name.text.trim(),
          email: email.text.trim(),
          mobile: phone.text.trim(),
          countryCode: countryCode.text.trim(),
          password: password.text.trim(),
        ),
      );

      isLoading = false;
      notifyListeners();

      debugPrint("response : ${response.success} - ${response.message}");

      if (response.success && response.data != null) {
        userDetails = response.data;

        return ApiResponse(
          success: true,
          message: response.message.isNotEmpty
              ? response.message
              : 'Registration successful',
          data: response.data,
        );
      }

      return ApiResponse(
        success: false,
        message: response.message.isNotEmpty
            ? response.message
            : 'Registration failed',
      );
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      debugPrint("Error: $e");

      return ApiResponse(success: false, message: "Something went wrong");
    }
  }

  //------------------------------------signup via google-----------------------------------

  Future<ApiResponse<SocialRegistetResponseModel>> signUpWithGoogle(
    String deviceType,
    String signUpType,
  ) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
        serverClientId:
            "11059384719-a0615feuqanf5o1lj4f72d6l7fgff7fi.apps.googleusercontent.com",
      );

      debugPrint("googleSignIn: $googleSignIn");

      // Open Google account picker
      final GoogleSignInAccount? account = await googleSignIn.signIn();

      debugPrint("Debug: $account");

      if (account == null) {
        return ApiResponse(success: false, message: "Soemthign wnt wrong");
      }

      // Get authentication tokens
      final GoogleSignInAuthentication auth = await account.authentication;

      final String? idToken = auth.idToken;
      final String? accessToken = auth.accessToken;
      final deviceId = await DeviceDetails.getDeviceId();

      final body = {
        "loginType": signUpType,
        "accessToken": accessToken,
        "deviceId": deviceId,
        "deviceType": deviceType,
        "deviceToken": "",
      };

      debugPrint("ID TOKEN: $idToken");
      debugPrint("ACCESS TOKEN: $accessToken");
      loading = true;

      // 🔥 Send token to backend
      final response = await _authRepository.socialRegister(body);

      debugPrint(
        "respoinse....... : ${response.data} ${response.data!.deviceId} ",
      );

      loading = false;
      notifyListeners();

      if (!response.success || response.data == null) {
        return ApiResponse(success: false, message: response.message);
      }
      debugPrint("accesstoken here : ${response.data!.token}");
      await _storage.saveSession(
        accessToken: response.data!.token,
        refreshToken: response.data!.refreshToken,
      );

      final token = await _storage.getAccessToken();

      debugPrint("accesstoken : $token");

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      debugPrint("e : $e");
      return ApiResponse(success: false, message: "Soemthign wnet wrong $e");
    }
  }

  Future<ApiResponse<SocialRegistetResponseModel>> signUpWithFacebook(
    String deviceType,
    String signUpType,
  ) async {
    debugPrint("ACCESS TOKEN: ");
    try {
      // final LoginResult result = await FacebookAuth.instance.login();
      String token = '';

      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      print("STATUS: ${result.status}");

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        token = accessToken.tokenString;

        print(token); // ✅ ACCESS TOKEN
      }
      // final String? idToken = auth.idToken;
      String? accessToken = token;

      final deviceId = await DeviceDetails.getDeviceId();

      final body = {
        "loginType": signUpType,
        "accessToken": accessToken,
        "deviceId": deviceId,
        "deviceType": deviceType,
        "deviceToken": "",
      };

      debugPrint("ACCESS TOKEN: $accessToken $deviceId $deviceType");
      loading = true;

      // 🔥 Send token to backend
      final response = await _authRepository.socialRegister(body);

      debugPrint(
        "respoinse....... : ${response.data} ${response.data!.deviceId} ",
      );

      loading = false;
      notifyListeners();

      if (!response.success || response.data == null) {
        return ApiResponse(success: false, message: response.message);
      }
      debugPrint("accesstoken here : ${response.data!.token}");
      await _storage.saveSession(
        accessToken: response.data!.token,
        refreshToken: response.data!.refreshToken,
      );

      final saveToken = await _storage.getAccessToken();

      debugPrint("accesstoken : $saveToken");

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      return ApiResponse(success: false, message: "Soemthign wnet wrong $e");
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    countryCode.dispose();
    super.dispose();
  }
}
