class ApiEndpoints {
  static const baseUrl = "http://192.168.2.67:5678";//server 
  // static const baseUrl = "http://192.168.2.65:5678";//local 

  //Auth
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

  // {{baseUrl}}/v1/user/ride/nearby?lat&lng
  //{{baseUrl}}/v1/user/ride/get-one?rideId=ride_id
  //{{baseUrl}}/v1/user/ride/active
}
