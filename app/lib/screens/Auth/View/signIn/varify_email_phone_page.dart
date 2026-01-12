import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/Auth/View/signIn/forget_pasword_page.dart';
import 'package:app/screens/Auth/View/signIn/forgetten_password_list.dart';
import 'package:app/screens/Auth/widgets/inputfield_widget.dart';

import 'package:flutter/material.dart';

class VarifyEmailPhonePage extends StatelessWidget {
  const VarifyEmailPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(  title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: const BackButton(),),
      body: Padding(padding: EdgeInsetsGeometry.all(16) , child: Column(
        children: [
          SizedBox(height: 10,),
          Text("Varify the email or phone number" ,  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          SizedBox(height: 10,),
          // InputfieldWidget(
          //   controller: TextEditingController(text: "1234"),
          //   hint: "Email or Phone number"),

          Spacer(),
           ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: AppColor.primaryYellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder:  (context)=>ForgetPaswordPage()));
              },
              child: Text("Send OTP" , style: TextStyle(color: Colors.white),),
            ),
        ],
      ),) ,
    );
  }
}