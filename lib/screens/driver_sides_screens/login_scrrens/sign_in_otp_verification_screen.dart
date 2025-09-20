import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../theme/app_theme.dart';
import '../home_screens/driver_dashboard_screen.dart';
import '../home_screens/earning_screens.dart';
import '../home_screens/under_rieview_screen.dart';
import 'driver_detail_screen.dart';

class SignInOtpVerificationScreen extends StatefulWidget {
  final String email;

  const SignInOtpVerificationScreen({super.key, required this.email});

  @override
  State<SignInOtpVerificationScreen> createState() =>
      _SignInOtpVerificationScreenState();
}

class _SignInOtpVerificationScreenState
    extends State<SignInOtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  final RxBool isLoading = false.obs;

  /// Verify OTP API call
  Future<void> verifyOtp() async {
    if (otpController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter the OTP",
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      debugPrint("❌ OTP field is empty");
      return;
    }

    try {
      isLoading.value = true;
      debugPrint("🔄 Sending OTP verification request...");

      final body = {
        "email": widget.email,
        "otp": otpController.text.trim(),
        "type": "login",
      };

      debugPrint("📩 Request Body: $body");

      final response = await http.post(
        Uri.parse(
            "https://vizoh-app.onrender.com/api/auth/driver/verify-email-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      debugPrint("📡 Response Status Code: ${response.statusCode}");
      debugPrint("📡 Response Body: ${response.body}");

      final data = jsonDecode(response.body);
      isLoading.value = false;

      if (response.statusCode == 200 && data["success"] == true) {
        final token = data["data"]["token"];
        final userId = data["data"]["id"];
        final email = widget.email;

        debugPrint("✅ OTP Verified Successfully!");
        debugPrint("🆔 User ID: $userId");
        debugPrint("📧 Email: $email");
        debugPrint("🔑 Token: $token");

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("auth_token", token);
        await prefs.setString("user_id", userId);
        await prefs.setString("email", email);
        await prefs.setBool("is_driver_logged_in", true);

        debugPrint("💾 Data saved to SharedPreferences");

        // Fetch driver verification & service status
        final verificationResponse = await http.get(
          Uri.parse(
              "https://vizoh-app.onrender.com/api/driver/selected-services"),
          headers: {"Authorization": "Bearer $token"},
        );

        if (verificationResponse.statusCode == 200) {
          final verificationData = jsonDecode(verificationResponse.body);
          debugPrint("🔹 Raw Verification Data: $verificationData");

          final data = verificationData['data'] ?? {};
          final verificationStatus = data['verificationStatus'] ?? "unknown";
          final serviceStatus = data['serviceStatus'] ?? "unknown";

          debugPrint("🔍 Verification Status: $verificationStatus");
          debugPrint("🔍 Service Status: $serviceStatus");

          // Navigate based on status
          if (verificationStatus == "pending" || serviceStatus == "pending") {
            Get.offAll(() => const UnderReviewScreen());
          } else if (verificationStatus == "approved" &&
              serviceStatus == "active") {
            Get.offAll(() => const VerificationSubmittedScreen());
          } else {
            // fallback
            Get.offAll(() => const UnderReviewScreen());
          }
        } else {
          // If fetching verification status fails
          Get.offAll(() => const EarningsScreen());
          Get.snackbar(
            "Warning",
            "Could not fetch verification status. Please try again later.",
            backgroundColor: AppColors.orange,
            colorText: AppColors.white,
          );
        }
      } else {
        debugPrint("❌ OTP Verification Failed: ${data["message"]}");
        Get.snackbar(
          "Error",
          data["message"] ?? "Invalid OTP",
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      debugPrint("🚨 Exception occurred: $e");
      debugPrint("🔍 StackTrace: $stackTrace");

      Get.snackbar(
        "Error",
        "Failed to connect to server",
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Sign In", style: TextStyle(color: AppColors.white)),
        centerTitle: true,
        backgroundColor: AppColors.skyBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
        
              /// Logo
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: AppColors.skyBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "V",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "vezoH",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.skyBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
        
              const SizedBox(height: 30),
        
              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Enter your email to sign in",
                style: TextStyle(color: AppColors.gray, fontSize: 14),
              ),
        
              const SizedBox(height: 25),
        
              /// Email field (read-only)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "EMAIL ADDRESS",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.gray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                initialValue: widget.email,
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined,
                      color: AppColors.skyBlue),
                  filled: true,
                  fillColor: AppColors.graybg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
        
              const SizedBox(height: 20),
        
              /// OTP field
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ENTER OTP",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.gray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter OTP",
                  filled: true,
                  fillColor: AppColors.graybg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
        
              const SizedBox(height: 8),
              Text(
                "OTP sent to ${widget.email}",
                style: const TextStyle(color: AppColors.gray, fontSize: 12),
              ),
        
              const SizedBox(height: 20),
        
              /// Verify OTP button
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading.value ? null : verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.skyBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: isLoading.value
                      ? const CircularProgressIndicator(
                    color: AppColors.white,
                  )
                      : const Text(
                    "Verify OTP",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              )),
        
              const SizedBox(height: 20),
        
              /// Sign Up link
              GestureDetector(
                onTap: () {
                  Get.to(() => const DriverDetailScreen());
                },
                child: const Text.rich(
                  TextSpan(
                    text: "Don’t have an account? ",
                    style: TextStyle(color: AppColors.gray),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: AppColors.skyBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
