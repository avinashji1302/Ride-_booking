import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/screens/Auth/View/signIn/set_password_page.dart';
import 'package:app/screens/Auth/ViewModel/forget_password_provider.dart';
import 'package:app/screens/Auth/ViewModel/sign_up_phone_varification_provider.dart';
import 'package:app/screens/Auth/model/forget_passowrd_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpPageVarififcation extends StatelessWidget {
  const OtpPageVarififcation({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    const Text(
                      "Phone verification",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Enter your OTP code",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 40),

                    /// OTP boxes
                    // TextField(
                    //   controller: controller.otpController,
                    //   keyboardType: TextInputType.number,
                    //   maxLength: 6,
                    //   decoration: const InputDecoration(
                    //     hintText: "Enter OTP",
                    //     border: OutlineInputBorder(),
                    //     counterText: "",
                    //   ),
                    // ),

                    const SizedBox(height: 20),

                    /// Resend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Didn’t receive code? "),
                        Text(
                          "Resend again",
                          style: TextStyle(
                            color: Color(0xFFF2B705),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: AppColor.primaryYellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        final result = await controller
                            .verifyForgetPasswordOtp();

                            debugPrint("result : $result");

                        if (result.success) {
                          AppSnackBar.show(
                            context,
                            message: result.message,
                            backgroundColor: Colors.green,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SetPasswordPage(),
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
                        "Varify",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
      ),
    );
  }
}

Widget otpBox() {
  return SizedBox(
    height: 40,
    width: 40,
    child: TextField(
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(border: OutlineInputBorder()),
    ),
  );
}
