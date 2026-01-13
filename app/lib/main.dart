
import 'package:app/screens/Auth/View/signup/phone_verification.dart';
import 'package:app/screens/Auth/View/signup/signup_page.dart';
import 'package:app/screens/Auth/ViewModel/forget_password_provider.dart';
import 'package:app/screens/Auth/ViewModel/opt_provider.dart';
import 'package:app/screens/Auth/ViewModel/sign_in_provider.dart';
import 'package:app/screens/Auth/ViewModel/signup_provider.dart';
import 'package:app/screens/appStart/view/welcome.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main()  async{

     WidgetsFlutterBinding.ensureInitialized();
   //  await Firebase.initializeApp();

     
  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => SignupProvider()),
         ChangeNotifierProvider(create: (_) => OptProvider()),
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
      ],
       child: MyApp(),
    ),
  );
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
