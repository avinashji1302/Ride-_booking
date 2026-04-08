import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/screens/Auth/ViewModel/sign_up_phone_varification_provider.dart';
import 'package:app/screens/Auth/ViewModel/signup_provider.dart';
import 'package:app/screens/Auth/widgets/inputfield_widget.dart';
import 'package:app/screens/home/view/home_page.dart';
import 'package:app/screens/landingPage/view/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneVerification extends StatelessWidget {
  const PhoneVerification({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Consumer<SignUpPhoneVarificationProvider>(
          builder:
              (
                BuildContext context,
                SignUpPhoneVarificationProvider controller,
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
                      InputFieldWidget(hint: "Enter your OTP", controller: controller.otpMobile , keyboardType: TextInputType.numberWithOptions(),),
        
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
                        onPressed: controller.loading
                            ? null
                            : () async {
                                final signupProvider = context
                                    .read<SignupProvider>();
        
                                final result = await controller.verifyOtp(
                                  mobileOtpId:
                                      signupProvider.userDetails!.mobileOtpId,
                                  emailOtpId:
                                      signupProvider.userDetails!.emailOtpId,
                                );
        
                                if (result.success) {
                                  AppSnackBar.show(
                                    context,
                                    message: result.message,
                                    backgroundColor: Colors.green,
                                  );
        
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => LandingPage()),
                                    (_) => false,
                                  );

                                  signupProvider.countryCode.clear();
                                   signupProvider.email.clear();
                                    signupProvider.name.clear();
                                     signupProvider.password.clear();
                                       signupProvider.phone.clear();
                                  
                                } else {
                                  AppSnackBar.show(
                                    context,
                                    message: result.message,
                                    backgroundColor: Colors.red,
                                  );
                                }
                              },
        
                        child: Text(
                          "Varify",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
        ),
      ),
    );
  }
}

Widget otpBox() {
  return SizedBox(
    height: 40,
    width: 40,
    child: TextField(
      maxLength: 1,
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(border: OutlineInputBorder()),
    ),
  );
}
