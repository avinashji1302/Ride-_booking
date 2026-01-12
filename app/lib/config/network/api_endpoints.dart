class ApiEndpoints {
  static const baseUrl = "http://192.168.2.239:5678";
    // static const baseUrl = "http://192.168.2.239:5678";
    


  static const register = "$baseUrl/v1/user/register";
  static const login = "$baseUrl/v1/user/login";
  static const sendLoginOtp = "$baseUrl/v1/user/sendLoginOtp";
  static const verifyOtp = "$baseUrl/v1/user/verifyOtp";
  static const forgotPassword = "/v1/user/forgotPassword";
  static const verifyForgotOtp = "/v1/user/verifyUserForgotPasswordOTP";
  static const resetPassword = "/v1/user/resetPassword";
  static const getProfile = "/v1/user/getProfile";
}
