class ApiConstants {
  static const String baseUrl = "https://vizoh-app.onrender.com/api";

  // Authentication endpoints
  static const String registerDriver = "$baseUrl/auth/register/driver";
  static const String verifyEmailOtp = "$baseUrl/auth/verify-email-otp";

  // Driver endpoints
  static const String optServices = "$baseUrl/driver/opt-services";
  static const String vehicleRegistration = "$baseUrl/driver/vehicle-registration";
  static const String profile = "$baseUrl/driver/profile";

// Add more endpoints as needed
}
