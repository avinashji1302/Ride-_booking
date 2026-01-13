import 'dart:io';

import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/Auth/View/signIn/sign_in_page.dart';
import 'package:app/screens/Auth/View/signup/signup_page.dart';
import 'package:flutter/material.dart';




class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             

              /// Illustration
              Image.asset(
                'assets/logo/carlogo.png', // replace with your image
                height: 260,
              ),

              const SizedBox(height: 30),

              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Have a better sharing experience",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const Spacer(),

              /// Create Account Button
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  },
                  child: const Text(
                    "Create an account",
                    style: TextStyle(fontSize: 16 , color: AppColor.white),
                    
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// Login Button with email
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColor.primaryYellow),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                  },
                  child: const Text(
                    "Log in with email",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.primaryYellow,
                    ),
                  ),
                ),
              ),
const SizedBox(height: 15),
                /// Login Button with phone
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColor.primaryYellow),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage(isPhone: true,)));
                  },
                  child: const Text(
                    "Log in with phone",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.primaryYellow,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
