import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_constants.dart';

class DriverLoginController extends GetxController {
  var isLoading = false.obs;
  String authToken = "";

  /// Verify OTP (for registration or login depending on the type parameter)
  Future<bool> verifyOtp({
    required String email,
    required String otp,
    required String type, // Must be either "login" or "registration"
  }) async {
    try {
      isLoading.value = true;

      final url = Uri.parse(ApiConstants.verifyRegistrationOtp);

      final body = jsonEncode({
        "email": email,
        "otp": otp,
        "type": "registration",   // Use the provided type parameter here
      });

      print("🔵 [VerifyOtp] URL: $url");
      print("🔵 [VerifyOtp] Body: $body");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("🔵 [VerifyOtp] Status Code: ${response.statusCode}");
      print("🔵 [VerifyOtp] Response Body: ${response.body}");

      final data = jsonDecode(response.body);
      String message = data["message"] ?? "Unknown error";

      if (response.statusCode == 200 && data["success"] == true) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool("is_driver_logged_in", true);

        if (data["data"] != null) {
          authToken = data["data"]["token"];
          await prefs.setString("auth_token", authToken);
          await prefs.setString("driver_id", data["data"]["id"]);

          // ✅ Print the token clearly
          print("🔑 Token: $authToken");
          print("🔑 Driver ID: ${data["data"]["id"]}");
        }

        Get.snackbar("Success", message);
        return true;
      } else {
        Get.snackbar("Error", message);
        print("❌ [VerifyOtp] OTP verification failed: $message");
        return false;
      }
    } catch (e, stackTrace) {
      print("🔥 [VerifyOtp] Exception: $e");
      print("🔥 [VerifyOtp] Stacktrace: $stackTrace");
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Example: call a protected API using stored token
  Future<void> getDriverProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token") ?? "";

    final url = Uri.parse(ApiConstants.profile);
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("🔵 [GetProfile] URL: $url");
    print("🔵 [GetProfile] Status: ${response.statusCode}");
    print("🔵 [GetProfile] Body: ${response.body}");
  }
}
