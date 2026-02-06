import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/config/network/api_repsonse.dart';
import 'package:app/screens/Auth/model/user_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import '../model/signup_model.dart';

class SignupProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  UserModel? userDetails;

  bool isLoading = false;
  String? errorMessage;

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController countryCode = TextEditingController(text: "91");

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Future<ApiResponse> register() async {
  //   isLoading = true;
  //   errorMessage = null;
  //   notifyListeners();

  //   try {
  //     final response = await _authRepository.register(
  //       SignupModel(
  //         fullName: name.text.trim(),
  //         email: email.text.trim(),
  //         mobile: phone.text.trim(),
  //         countryCode: countryCode.text.trim(),
  //         password: password.text,
  //       ),
  //     );

  //     isLoading = false;
  //     notifyListeners();

  //     debugPrint("response : ${response.success}");

  //     if (response.success && response.data != null) {
  //       userDetails = response.data;

  //       return ApiResponse(
  //         success: true,
  //         message: response.message,
  //         data: response.data,
  //       );
  //     }

  //     return ApiResponse(
  //       success: false,
  //       message: response.message,
  //     );
  //   } catch (e) {
  //     isLoading = false;
  //     errorMessage = e.toString();
  //     notifyListeners();

  //     return ApiResponse(
  //       success: false,
  //       message: "Something went wrong $e",
  //     );
  //   }
  // }

  Future<ApiResponse<UserModel?>> register(BuildContext context) async {
    isLoading = true;
    notifyListeners();

   // final response = await _authRepository.register(
  //     SignupModel(
  //       fullName: name.text.trim(),
  //       email: email.text.trim(),
  //       mobile: phone.text.trim(),
  //       countryCode: countryCode.text.trim(),
  //       password: password.text,
  //     ),
  //   );

  //  isLoading = true;
  //   errorMessage = null;
  //   notifyListeners();

    try {
      final response = await _authRepository.register(
        SignupModel(
          fullName: name.text.trim(),
          email: email.text.trim(),
          mobile: phone.text.trim(),
          countryCode: countryCode.text.trim(),
          password: password.text,
        ),
      );

      isLoading = false;
      notifyListeners();

      debugPrint("response : ${response.success} - ${response.message}");

      if (response.success && response.data != null) {
        userDetails = response.data;

        return ApiResponse(
          success: true,
          message: response.message.isNotEmpty ? response.message : 'Registration successful',
          data: response.data,
        );
      }

      return ApiResponse(
        success: false,
        message: response.message.isNotEmpty ? response.message : 'Registration failed',
      );
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      debugPrint("Error: $e");

      return ApiResponse(
        success: false,
        message: "Something went wrong",
      );
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
