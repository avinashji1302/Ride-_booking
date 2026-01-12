import 'package:app/config/colors/app_color.dart';
import 'package:app/config/device/device_details.dart';
import 'package:app/config/validars/validators.dart';
import 'package:app/screens/Auth/View/signup/set_password_page.dart';
import 'package:app/screens/Auth/ViewModel/opt_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneVerification extends StatelessWidget {

  const  PhoneVerification({super.key});
  @override
  Widget build(BuildContext context) {
   
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      body: Consumer<OptProvider>(
        builder: (BuildContext context, OptProvider controller, Widget? child) { 

           return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
        
              const Text(
                "Phone verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
        
              const SizedBox(height: 8),
        
              const Text(
                "Enter your OTP code",
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
                onPressed: ()  async{
                 
             context.read<OptProvider>().verifyOtp(context);
                },
                child: Text("Varify" , style: TextStyle(color: Colors.white),),
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
      decoration: InputDecoration(border: OutlineInputBorder())),
  );
}
