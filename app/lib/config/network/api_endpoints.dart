class ApiEndpoints {
  static const baseUrl = "http://192.168.2.143:5678";
  // static const baseUrl = "http://192.168.2.239:5678";



  static const register = "$baseUrl/v1/user/register";
  static const login = "$baseUrl/v1/user/login";
  static const sendLoginOtp = "$baseUrl/v1/user/sendLoginOtp";
  static const verifyOtp = "$baseUrl/v1/user/verifyOtp";
  static const forgotPassword = "$baseUrl/v1/user/forgotPassword";
  static const verifyForgotOtp = "$baseUrl/v1/user/verifyUserForgotPasswordOTP";
  static const resetPassword = "$baseUrl/v1/user/resetPassword";
  static const estimate = "$baseUrl/v1/user/ride/estimate";
  static const rideCreate = "$baseUrl/v1/user/ride/create";
   static const cancelRide = "$baseUrl/v1/user/ride/cancel";
  static const logout = "$baseUrl/v1/user/logout";
}
