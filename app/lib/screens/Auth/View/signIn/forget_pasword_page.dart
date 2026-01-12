import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/Auth/View/signIn/varify_email_phone_page.dart';
import 'package:app/screens/Auth/View/signup/set_password_page.dart';
import 'package:flutter/material.dart';

class ForgetPaswordPage extends StatelessWidget {
  const ForgetPaswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Text(
              "Forget Password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Code has been sent to this 63897*****",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 40),

            /// OTP boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: List.generate(5, (index) {
                return otpBox();
              }),
            ),

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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:  (context)=>VarifyEmailPhonePage()));
              },
              child: Text("Varify" , style: TextStyle(color: Colors.white),),
            ),
          ],
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
      keyboardType: TextInputType.numberWithOptions(),
      decoration: InputDecoration(border: OutlineInputBorder())),
  );
}
