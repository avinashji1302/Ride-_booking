import 'package:app/config/colors/app_color.dart';
import 'package:app/config/validars/validators.dart';
import 'package:app/screens/Auth/View/signIn/sign_in_page.dart';
import 'package:app/screens/Auth/View/signup/profile_page.dart';
import 'package:app/screens/Auth/widgets/inputfield_widget.dart';
import 'package:flutter/material.dart';

class SetPasswordPage extends StatelessWidget {
  SetPasswordPage({super.key});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Set Password",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "Set Your Password",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 24),
              InputFieldWidget(
                controller: controller,
                hint: "New Password",
                isPassword: true,
                validator: Validators.validatePassword,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 20),
              InputFieldWidget(
                controller: controller,
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
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ProfilePage(),
                    //   ),
                    // );
                  },
                  child: const Text(
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
      ),
    );
  }
}
