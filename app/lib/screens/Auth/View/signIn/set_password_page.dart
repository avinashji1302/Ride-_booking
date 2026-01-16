import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/config/validars/validators.dart';

import 'package:app/screens/Auth/ViewModel/forget_password_provider.dart';
import 'package:app/screens/Auth/ViewModel/reset_password_provider.dart';
import 'package:app/screens/Auth/widgets/inputfield_widget.dart';
import 'package:app/screens/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetPasswordPage extends StatelessWidget {
  SetPasswordPage({super.key});


  @override
  Widget build(BuildContext context) {
    final forgetProvider = context.read<ForgetPasswordProvider>();
    final email = forgetProvider.authResult!.email;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      body: Consumer<ResetPasswordProvider>(
        builder:
            (
              BuildContext context,
              ResetPasswordProvider resetController,
              Widget? child,
            ) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Set Password",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Set Your Password",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),

                      const SizedBox(height: 24),
                      InputFieldWidget(
                        controller: resetController.newPassword,
                        hint: "New Password",
                        isPassword: true,
                        validator: Validators.validatePassword,
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 20),
                      InputFieldWidget(
                        controller: resetController.confirmPassword,
                        hint: " Confirm Password",
                        isPassword: true,
                        validator: Validators.validatePassword,
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 20),

                      Spacer(),

                      /// Sign up button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryYellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            final result = await resetController.resetPassword(
                              email,
                            );

                            debugPrint("Sucesss: ${result.message} ${result.data} ${result.success}");

                            if (result.success) {
                              AppSnackBar.show(
                                context,
                                message: result.message,
                                backgroundColor: Colors.green,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomePage(),
                                ),
                              );
                            } else {
                              AppSnackBar.show(
                                context,
                                message: result.message,
                                backgroundColor: Colors.red,
                              );
                            }
                          },
                          child: resetController.loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            :  const Text(
                            "New Passowrd",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
      ),
    );
  }
}
