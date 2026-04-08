class ApiEndpoints {
  static const baseUrl = "http://192.168.2.244:56789"; //server
  // static const baseUrl = "http://192.168.2.65:5678";//local

  //Auth
  static const register = "$baseUrl/v1/user/register";
  static const login = "$baseUrl/v1/user/login";
  //   static const sendLoginOtp = "$baseUrl/v1/user/sendLoginOtp";
  static const verifyOtp = "$baseUrl/v1/user/verifyOtp";
  static const forgotPassword = "$baseUrl/v1/user/forgotPassword";
  static const verifyForgotOtp = "$baseUrl/v1/user/verifyUserForgotPasswordOTP";
  static const resetPassword = "$baseUrl/v1/user/resetPassword";

  static const estimate = "$baseUrl/v1/user/ride/estimate";
  static const rideCreate = "$baseUrl/v1/user/ride/create";
  static const cancelRide = "$baseUrl/v1/user/ride/cancel";
  static const logout = "$baseUrl/v1/user/logout";

  //Social Signup

  static const socialSignUp = "$baseUrl/v1/user/socialSignup";
  static const socialLogin = "$baseUrl/v1/user/socialLogin";
  static const sendOtpSocialSignUp = "$baseUrl/v1/user/send-otp-social-signup";
  static const verifyOtpSocialSignup =
      "$baseUrl/v1/user/verify-otp-social-signup";

  //login without password
  static const sendLoginOtp = "$baseUrl/v1/user/sendLoginOtp";
  static const verifyLoginOtp = "$baseUrl/v1/user/verifyLoginOtp";

  static const sendEmailLoginOtp = "$baseUrl/v1/user/sendEmailLoginOtp";
  static const verifyEmailLoginOtp = "$baseUrl/v1/user/verifyEmailLoginOtp";

  static const resendOTPMobile = "$baseUrl/v1/user/resendOTPMobile";
  static const resendEmailLoginOtp = "$baseUrl/v1/user/resendEmailLoginOtp";

  //   POST -- {{baseUrl}}/v1/user/resendOTPMobile

  // {
  //     "mobile": "911987344",
  //     "countryCode": "+91"
  // }

  // {
  //     "success": false,
  //     "message": "Mobile not found.",
  //     "results": {}
  // }

  // POST -- {{baseUrl}}/v1/user/resendEmailLoginOtp

  // {
  //     "email": "avinash@gmail.com"
  // }

  // {
  //     "success": true,
  //     "message": "OTP resent successfully on email.",
  //     "results": {
  //         "emailOtpId": "69cdf6a1ac80085845a89663"
  //     }
  // }

  static const categoryList = "$baseUrl/v1/user/category-list";

  // {

  //   {{baseUrl}}/v1/user/category-list

  //profile
  static const profile = "$baseUrl/v1/user/getProfile";
  static const updateProfile = "$baseUrl/v1/user/updateProfile";
  static const uploadImage = "$baseUrl/v1/user/upload-image";

  //other
  static const coupon = "$baseUrl/v1/user/ride/apply-promo";
  static const schedule = "$baseUrl/v1/user/ride/schedule";
  static const rating = "$baseUrl/v1/user/rating";

  //payment
  static const upiPayment =
      "$baseUrl/v1/user/wallet/payment-details?paymentMethod=upi";
  static const walletRechare = "$baseUrl/v1/user/wallet/recharge";
  static const pendingPayemnt =
      "$baseUrl/v1/user/wallet/pending-recharge-requests?page=1&pageSize=10";

  static const duePayment = "$baseUrl/v1/user/ride/paymentDue";
  static const paymentDone = "$baseUrl/v1/user/ride/paidPayment";

  static const nearBy = "$baseUrl/v1/user/ride/nearby";
  static const getOne = "$baseUrl/v1/user/ride/get-one";
  static const activeRide = "$baseUrl/v1/user/ride/active";

  //user static data ----------

  static const getBanners = "$baseUrl/v1/user/staticcontent/getBanners";
  static const faq = "$baseUrl/v1/user/staticcontent/faq";
  static const getStaticSlug = "$baseUrl/v1/user/staticcontent/getStaticSlug";
  static const String notifications = "$baseUrl/v1/user/notification";
  static const String notificationsToggle =
      "$baseUrl/v1/user/notification/notification-toggle";

  //-----------------Address------------------------

  static const String getAddress = "$baseUrl/v1/user/address";
}
