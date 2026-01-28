import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/Auth/ViewModel/forget_password_provider.dart';
import 'package:app/screens/Auth/ViewModel/sign_up_phone_varification_provider.dart';
import 'package:app/screens/Auth/ViewModel/sign_in_provider.dart';
import 'package:app/screens/Auth/ViewModel/signup_provider.dart';
import 'package:app/screens/appStart/view/welcome.dart';
import 'package:app/screens/home/view/home_page.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:app/screens/old_money/view_model/ola_money_provider.dart';
import 'package:app/screens/profile/viewmodel/logout_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // ✅ Initialize Firebase (uncomment when needed)
  // await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => SignUpPhoneVarificationProvider()),
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
         ChangeNotifierProvider(create: (_) => HomeProvider()),
         ChangeNotifierProvider(create: (_) => ProfileProvider()), 
                  ChangeNotifierProvider(create: (_) => OlaMoneyProvider()), 

        // ✅ Don't initialize ResetPasswordProvider here - it needs parameters
        // ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        // ✅ Use AuthCheck widget to determine initial screen
        home: const AuthCheck(),
      ),
    );
  }
}


class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final authStorage = AuthStorage();
      final accessToken = await authStorage.getAccessToken();
      
      debugPrint("📱 Access Token: $accessToken");

      setState(() {
        _isLoggedIn = accessToken != null && accessToken.isNotEmpty;
        _isLoading = false;
      });

      debugPrint("✅ Login Status: ${_isLoggedIn ? 'Logged In' : 'Not Logged In'}");
    } catch (e) {
      debugPrint("❌ Error checking login status: $e");
      setState(() {
        _isLoggedIn = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

   
    return _isLoggedIn 
        ? const HomePage()  
        : const WelcomeScreen(); 
  }
}