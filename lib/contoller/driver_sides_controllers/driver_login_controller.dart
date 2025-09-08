import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_constants.dart';

class DriverLoginController extends GetxController {
  var isLoading = false.obs;

  /// Verify Driver OTP API
  Future<bool> verifyDriverOtp({
    required String email,
    required String otp,
  }) async {
    try {
      isLoading.value = true;

      final url = Uri.parse(ApiConstants.verifyEmailOtp);

      final body = jsonEncode({
        "email": email,
        "otp": otp,
        "type": "registration", // backend requires this field
      });

      print("🔵 [DriverVerifyOtp] Calling API: $url");
      print("🔵 [DriverVerifyOtp] Body: $body");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("🔵 [DriverVerifyOtp] Response: ${response.statusCode}");
      print("🔵 [DriverVerifyOtp] Body: ${response.body}");

      dynamic data;
      try {
        data = jsonDecode(response.body);
      } catch (_) {
        Get.snackbar("Error", "Invalid response from server");
        return false;
      }

      if (response.statusCode == 200) {
        if (data["success"] == true) {
          /// Save login state
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool("is_driver_logged_in", true);

          Get.snackbar("✅ Success", data["message"]);
          return true;
        } else {
          Get.snackbar("❌ Error", data["message"] ?? "Verification failed");
        }
      } else {
        Get.snackbar("❌ Error", "Server returned ${response.statusCode}");
      }
      return false;
    } catch (e, stackTrace) {
      print("🔥 [DriverVerifyOtp] Exception: $e");
      print("🔥 [DriverVerifyOtp] Stacktrace: $stackTrace");
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
