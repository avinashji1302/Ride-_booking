import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/common_button.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/screens/Auth/View/signIn/varify_with_otp_login.dart';
import 'package:app/screens/Auth/ViewModel/sign_in_provider.dart';
import 'package:app/screens/Auth/widgets/inputfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginWithOtp extends StatelessWidget {
  const LoginWithOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login via OTP"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Consumer<SignInProvider>(
        builder:
            (BuildContext context, SignInProvider controller, Widget? child) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: controller.otpFormKey,
                    child: Column(
                      children: [
                        InputFieldWidget(
                          controller: controller.inputController,
                          hint: "Enter Email or Phone",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 520),

                        CommonButton(
                          title: 'Recvied OTP',
                          onPressed: () async {
                            final result = await controller.signInWithOtp(
                              context,
                            );

                            if (result.success) {
                              AppSnackBar.show(
                                context,
                                message: result.message,
                                backgroundColor: Colors.green,
                              );

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => VarifyWithOtpLogin(),
                                ),
                              );
                            } else {
                              AppSnackBar.show(
                                context,
                                message: result.message,
                                backgroundColor: Colors.green,
                              );
                            }
                          },

                          backgroundColor: AppColor.primaryYellow,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
      ),
    );
  }
}
