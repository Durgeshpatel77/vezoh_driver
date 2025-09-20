import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:vezoh_driver/screens/driver_sides_screens/login_scrrens/sign_in_otp_verification_screen.dart';
import '../../../theme/app_theme.dart';
import 'driver_detail_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final RxBool isLoading = false.obs;

  /// Function to call login API
  Future<void> sendOtp() async {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter your email",
          backgroundColor: AppColors.red, colorText: AppColors.white);
      debugPrint("❌ Email field is empty");
      return;
    }

    try {
      isLoading.value = true;
      final email = emailController.text.trim();
      debugPrint("🔄 Sending OTP request...");
      debugPrint("📩 Request Body: {email: $email}");

      final response = await http.post(
        Uri.parse("https://vizoh-app.onrender.com/api/auth/login/driver"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      debugPrint("📡 Response Status Code: ${response.statusCode}");
      debugPrint("📡 Response Body: ${response.body}");

      final data = jsonDecode(response.body);
      isLoading.value = false;

      if (response.statusCode == 200 && data["success"] == true) {
        debugPrint("✅ OTP Sent Successfully!");
        debugPrint("📨 Message: ${data["message"]}");
        debugPrint("📧 Email: $email");

        Get.snackbar("Success", data["message"],
            backgroundColor: AppColors.green, colorText: AppColors.white);

        /// Navigate to OTP screen
        Get.to(() => SignInOtpVerificationScreen(email: email));
      } else {
        debugPrint("❌ Failed to send OTP: ${data["message"]}");
        Get.snackbar("Error", data["message"] ?? "Something went wrong",
            backgroundColor: AppColors.red, colorText: AppColors.white);
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      debugPrint("🚨 Exception occurred: $e");
      debugPrint("🔍 StackTrace: $stackTrace");

      Get.snackbar("Error", "Failed to connect to server",
          backgroundColor: AppColors.red, colorText: AppColors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Sign In",
            style: TextStyle(color: AppColors.white, fontSize: 18)),
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

              /// App Logo
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

              /// Email field
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
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined,
                      color: AppColors.skyBlue),
                  hintText: "Enter your email address",
                  hintStyle: const TextStyle(color: AppColors.gray),
                  filled: true,
                  fillColor: AppColors.graybg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Send OTP button
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading.value ? null : sendOtp,
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
                    "Send OTP",
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
