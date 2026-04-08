import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/screens/Auth/ViewModel/sign_in_provider.dart';
import 'package:app/screens/Auth/widgets/inputfield_widget.dart';
import 'package:app/screens/landingPage/view/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VarifyWithOtpLogin extends StatelessWidget {
  const VarifyWithOtpLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SignInProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              const Text(
                "Sign in Varification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                "Enter your OTP code",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 40),

              /// OTP boxes
              InputFieldWidget(
                hint: "Enter your OTP",
                controller: controller.varifyLoginOtp,
                keyboardType: TextInputType.numberWithOptions(),
              ),
              const SizedBox(height: 20),

              /// Resend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn’t receive code? "),
                  GestureDetector(
                    onTap: () async {
                      final result = await controller.reSendOTP(context);

                      if (result.success) {
                        AppSnackBar.show(
                          context,
                          message: result.message,
                          backgroundColor: Colors.green,
                        );
                      } else {
                        AppSnackBar.show(
                          context,
                          message: result.message,
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: Text(
                      "Resend again",
                      style: TextStyle(
                        color: Color(0xFFF2B705),
                        fontWeight: FontWeight.bold,
                      ),
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
                  final result = await controller.varidySignInWithOtp(context);

                  if (result.success) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                      (route) => false,
                    );

                    AppSnackBar.show(
                      context,
                      message: result.message,
                      backgroundColor: Colors.green,
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
                    : Text("Varify", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
