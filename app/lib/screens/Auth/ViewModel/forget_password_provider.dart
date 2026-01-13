import 'package:app/screens/Auth/View/signIn/otp_page_varififcation.dart';
import 'package:app/screens/Auth/View/signIn/sign_in_page.dart';
import 'package:app/screens/Auth/View/signIn/set_password_page.dart';
import 'package:app/screens/Auth/model/forget_passowrd_model.dart';
import 'package:app/screens/Auth/model/varifty_user_forget_password_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  final AuthRepository repository = AuthRepository();
  final TextEditingController emailController = TextEditingController();
    final TextEditingController otp = TextEditingController();
  bool isLoading = false;
  ForgetPassowrdModel? authResult;
  String? error;
  Future<bool> forgetPassword(BuildContext context) async {
    try {
      final response = await repository.forgetPassword(
        ForgetPassowrdModelRequest(email: emailController.text, type: "email"),
      );

      debugPrint("response  : ${response.success}  ");
      final message = response.message;
      isLoading = false;
      notifyListeners();

      debugPrint("Sucess : ${response.success}  ");
      debugPrint("Sucess : ${response.message}  ");
       authResult = response.data!;

      debugPrint("result : ${authResult!.id}  ");
      if (response.success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpPageVarififcation(

          )),
        );

        return true;
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));

        return false;
      }
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      return false;
    }
  }


  //varify forget password---------------

  Future<bool> varifyForgetPasswordOtp(BuildContext context) async {

    debugPrint("Data is. ${authResult!.countryCode}.  ${authResult!.id}  ${authResult!.otp}  ${authResult!.email} ");

     if (authResult == null) {
    error = "No OTP session found. Please request OTP again.";
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please request OTP first")),
    );
    return false;
  }
    try {
      final response = await repository.variftForgetPasswordOtp(
        VariftyUserForgetPasswordModel(type: 'email', otpId:authResult!.id , email: authResult!.email, otp:authResult!.otp.toString()),
      );

      debugPrint("response  : ${response.success}  ");
      final message = response.message;
      isLoading = false;
      notifyListeners();

      debugPrint("Sucess : ${response.success}  ");
      debugPrint("Sucess : ${response.message}  ");
      

     
      if (response.success) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SetPasswordPage(
            
          )),
        );

        return true;
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));

        return false;
      }
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
