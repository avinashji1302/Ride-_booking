import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/config/validars/validators.dart';
import 'package:app/screens/Auth/View/signIn/forget_pasword_page.dart';
import 'package:app/screens/Auth/View/signIn/forgetten_password_list.dart';
import 'package:app/screens/Auth/View/signIn/otp_page_varififcation.dart';
import 'package:app/screens/Auth/ViewModel/forget_password_provider.dart';
import 'package:app/screens/Auth/widgets/inputfield_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VarifyEmailPhonePage extends StatelessWidget {
  const VarifyEmailPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      body: Consumer<ForgetPasswordProvider>(
        builder:
            (
              BuildContext context,
              ForgetPasswordProvider controller,
              Widget? child,
            ) {
              return Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Varify the email or phone number",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    InputFieldWidget(
                      controller: controller.emailController,
                      hint: "Email",
                      validator: Validators.validateEmail,
                      keyboardType: TextInputType.emailAddress,

                      prefixIcon: const Icon(Icons.email),
                    ),

                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: AppColor.primaryYellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        final result = await controller.forgetPassword();

                        if (result.success) {
                          AppSnackBar.show(
                            context,
                            message: result.message,
                            backgroundColor: Colors.green,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const OtpPageVarififcation(),
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

                       child: controller.loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            :  Text(
                        "Send OTP",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              );
            },
      ),
    );
  }
}
