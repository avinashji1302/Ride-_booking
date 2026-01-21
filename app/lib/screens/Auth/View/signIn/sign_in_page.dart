import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/config/validars/validators.dart';
import 'package:app/screens/Auth/View/signIn/varify_email_phone_page.dart';
import 'package:app/screens/Auth/View/signup/signup_page.dart';
import 'package:app/screens/Auth/ViewModel/sign_in_provider.dart';
import 'package:app/screens/Auth/widgets/inputfield_widget.dart';
import 'package:app/screens/Auth/widgets/social_widget.dart';
import 'package:app/screens/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  bool? isPhone;

  SignInPage({super.key, this.isPhone = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      body: Consumer<SignInProvider>(
        builder:
            (BuildContext context, SignInProvider controller, Widget? child) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 24),

                      !isPhone!
                          ? InputFieldWidget(
                              controller: controller.emailController,
                              hint: "Email",
                              validator: Validators.validateEmail,
                              keyboardType: TextInputType.emailAddress,

                              prefixIcon: const Icon(Icons.email),
                            )
                          : InputFieldWidget(
                              controller: controller.emailController,
                              hint: "Phone",
                              validator: Validators.validatePhone,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              prefixIcon: const Icon(Icons.phone),
                            ),
                      SizedBox(height: 10),
                      InputFieldWidget(
                        controller: controller.passController,
                        hint: "Password",
                        isPassword: true,
                        validator: Validators.validatePassword,
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VarifyEmailPhonePage(),
                            ),
                          );
                        },
                        child: Text(
                          "Forget Password",
                          style: TextStyle(color: Colors.red),
                          textDirection: TextDirection.rtl,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Sign in button
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
                            final result = await controller.signIn(context , isPhone!);

                            if (result.success) {
                              AppSnackBar.show(
                                context,
                                message: result.message,
                                backgroundColor: Colors.green,
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => HomePage()),
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
                            :    const Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("or"),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// Social buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SocialButton(icon: Icons.mail),
                          SizedBox(width: 15),
                          SocialButton(icon: Icons.facebook),
                          SizedBox(width: 15),
                          SocialButton(icon: Icons.apple),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// Footer
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(text: "Did not have an account? "),
                                TextSpan(
                                  text: "Sign up",
                                  style: TextStyle(
                                    color: AppColor.primaryYellow,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
      ),
    );
  }
}
