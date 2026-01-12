import 'package:app/screens/Auth/View/signup/phone_verification.dart';
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

  // ✅ Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<bool> register(BuildContext context) async {
 
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fix the errors in the form"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

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
      userDetails = response.user;

      debugPrint("Response : $userDetails ${response.user}");

      final success = response.success;

      isLoading = false;
      notifyListeners();

      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PhoneVerification()),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong")),
        );
        return false;
      }
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
      return false;
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