// lib/core/constants/api_constants.dart

class ApiConstants {
  static const String baseUrl = "https://vizoh-app.onrender.com/api";

  // Auth endpoints
  static const String registerDriver = "$baseUrl/auth/register/driver";
  static const String verifyEmailOtp = "$baseUrl/auth/verify-email-otp";
}
