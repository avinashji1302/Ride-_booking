class VariftyUserForgetPasswordModel {
  final String type;
  final String otpId;
  final String email;
  final String otp;

  VariftyUserForgetPasswordModel({
    required this.type,
    required this.otpId,
    required this.email,
    required this.otp,
  });


  Map<String, dynamic>  toJson(){
    return {
       "type":type,
       "otpId":otpId,
       "email":email,
       "otp":otp

    };
  }
}

  // "type": "email",
  // "otpId": "6965f08af0a370ecb83e3463",
  // "email": "john123456@exam0ple.com",
  // "otp": "9965"