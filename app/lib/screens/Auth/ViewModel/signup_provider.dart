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
  final TextEditingController countryCode =
      TextEditingController(text: "91");

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<ApiResponse> register() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

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

      if (response.success && response.user != null) {
        userDetails = response.user;

        return ApiResponse(
          success: true,
          message: response.message,
          data: response.user,
        );
      }

      return ApiResponse(
        success: false,
        message: response.message,
      );
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();

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
