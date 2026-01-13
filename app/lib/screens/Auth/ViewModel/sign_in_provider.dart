import 'package:app/config/device/device_details.dart';
import 'package:app/config/network/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/Auth/model/signin_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:app/screens/home/view/home_page.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final AuthStorage _storage = AuthStorage();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
 bool loading = true;
    String? error;
  Future<bool> signIn(BuildContext context ,  bool isPhone) async {
    final deviceId = await DeviceDetails.getDeviceId();
   
 
    notifyListeners();
    try {
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

      final message = response.message;
      final loginResposne = response.data;

      debugPrint("data : $emailController , $passController $deviceId ${response.data} $isPhone");

      if (response.success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );

        emailController.clear();
        passController.clear();
        return true;
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }

      await _storage.saveSession(
        accessToken: loginResposne!.token,
        refreshToken: loginResposne.refreshToken,
      );

      return false;
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
      return false;
    
    }
  }


    @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }
}
 