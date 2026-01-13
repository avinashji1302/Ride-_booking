import 'package:app/config/device/device_details.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/Auth/View/signIn/sign_in_page.dart';
import 'package:app/screens/Auth/ViewModel/signup_provider.dart';
import 'package:app/screens/Auth/model/otp_varify_model.dart';
import 'package:app/screens/Auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptProvider extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();
    final AuthStorage _storage = AuthStorage();
  final TextEditingController otpMobile = TextEditingController();

    bool loading = false;
    String? error;
  VarifyOtpUserResult? user;

  Future<bool> verifyOtp(BuildContext context) async {
final signupProvider =
      Provider.of<SignupProvider>(context, listen: false);
    final deviceId = await DeviceDetails.getDeviceId();

    debugPrint("Sucess : ${signupProvider.userDetails?.mobileOtpId} ${deviceId } ${signupProvider.userDetails?.emailOtpId}");


    loading = true;
    notifyListeners();

    final response = await _repo.verifySignUpOtp(
      VerifyOtpRequest(
        deviceId: deviceId,
        mobileOtpId: signupProvider.userDetails!.mobileOtpId,
        emailOtpId: signupProvider.userDetails!.emailOtpId,
        otpMobile: '1234',
        otpEmail: '1234',
        deviceType: 'android',
        deviceToken: '',
      ),
    );

    loading = false;

    if (!response.success) {
      error = response.message;
      notifyListeners();
      return false;
    }

    debugPrint("Sucess : ${response.success} ${deviceId }");

    final authResult = response.data!;
    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(response.message)),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  SignInPage()),
        );
       
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
        
      }

    await _storage.saveSession(
      accessToken: authResult.token,
      refreshToken: authResult.refreshToken,
    );

    notifyListeners();
    return true;
  }


    @override
  void dispose() {
    otpMobile.dispose();
   

    super.dispose();
  }
}
