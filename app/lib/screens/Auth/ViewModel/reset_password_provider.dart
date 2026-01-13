import 'package:app/screens/Auth/model/reset_password_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class ResetPasswordProvider extends ChangeNotifier{
  final AuthRepository repository = AuthRepository();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();


  // Future<bool> resetPassword() async{

  //   final response = await repository.resetPassword(ResetPasswordModel(email: '', newPassword: newPassword.text.trim(), confirmPassword: confirmPassword.text.trim()

  //   ));

  // }
}