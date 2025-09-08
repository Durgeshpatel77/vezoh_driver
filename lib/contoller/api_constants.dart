class ApiConstants {
  static const String baseUrl = "https://vizoh-app.onrender.com/api";

  // Authentication endpoints
  static const String registerDriver = "$baseUrl/auth/register/driver";
  static const String verifyRegistrationOtp = "$baseUrl/auth/driver/verify-email-otp";
  static const String verifyLoginOtp = "$baseUrl/auth/verify-email-otp"; // if needed separately
  static const String loginDriver = "$baseUrl/auth/login/driver";
  static const String loginDriverOtp = "$baseUrl/auth/driver/request-login-otp"; // ensure this is correct

  // Driver endpoints
  static const String profile = "https://vizoh-app.onrender.com/api/driver/selected-services";
}
