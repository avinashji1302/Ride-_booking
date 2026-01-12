import 'package:app/config/colors/app_color.dart';
import 'package:app/config/validars/validators.dart';
import 'package:app/screens/Auth/ViewModel/signup_provider.dart';
import 'package:app/screens/Auth/widgets/inputfield_widget.dart';
import 'package:app/screens/Auth/widgets/social_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Consumer<SignupProvider>(
            builder: (context, provider, child) {
              return Form(
                key: provider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// Name field
                    InputFieldWidget(
                      controller: provider.name,
                      hint: "Full Name",
                      validator: Validators.validateName,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    const SizedBox(height: 16),

                    /// Email field
                    InputFieldWidget(
                      controller: provider.email,
                      hint: "Email Address",
                      validator: Validators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 16),

                    /// Phone field
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Country code
                        SizedBox(
                          width: 100,
                          child: InputFieldWidget(
                            controller: provider.countryCode,
                            hint: "+91",
                            validator: Validators.validateCountryCode,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            prefixIcon: const Icon(Icons.flag),
                          ),
                        ),
                        const SizedBox(width: 10),
                        
                        // Phone number
                        Expanded(
                          child: InputFieldWidget(
                            controller: provider.phone,
                            hint: "Mobile Number",
                            validator: Validators.validatePhone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            prefixIcon: const Icon(Icons.phone_outlined),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Password field
                    InputFieldWidget(
                      controller: provider.password,
                      hint: "Password",
                      isPassword: true,
                      validator: Validators.validatePassword,
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                    const SizedBox(height: 12),

                    /// Terms
                    Row(
                      children: const [
                        Icon(Icons.check_circle, color: Colors.green, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "By signing up, you agree to the Terms of service and Privacy policy.",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

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
                        onPressed: provider.isLoading
                            ? null
                            : () async {
                                await provider.register(context);
                              },
                        child: provider.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// OR divider
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
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "Sign in",
                              style: TextStyle(
                                color: AppColor.primaryYellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}