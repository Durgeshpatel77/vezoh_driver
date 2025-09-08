import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../contoller/driver_sides_controllers/driver_login_controller.dart';
import '../../../theme/app_theme.dart';
import '../home_screens/driver_dashboard_screen.dart';
import '../verification_screens/welcome_screen.dart';

class DriverOtpScreen extends StatefulWidget {
  final String email;

  const DriverOtpScreen({super.key, required this.email});

  @override
  State<DriverOtpScreen> createState() => _DriverOtpScreenState();
}

class _DriverOtpScreenState extends State<DriverOtpScreen> {
  final otpController = TextEditingController();
  final driverLoginController = Get.put(DriverLoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.skyBlue,
          elevation: 0,
          title: const Text(
            "Driver Verification",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 112),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.skyBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "V",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Text("vezoH",
                  style: TextStyle(fontSize: 14, color: Colors.blueGrey)),
              const SizedBox(height: 24),

              const Text(
                "Verify your account",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                "Enter the OTP sent to your email",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("EMAIL ADDRESS",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: widget.email,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("ENTER OTP",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("OTP sent to ${widget.email}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ),
              const SizedBox(height: 24),

              Obx(() => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.skyBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: driverLoginController.isLoading.value
                      ? null
                      : () async {
                    final otp = otpController.text.trim();
                    if (otp.isEmpty) {
                      Get.snackbar("Error", "Please enter OTP");
                      return;
                    }

                    final success = await driverLoginController.verifyDriverOtp(
                      email: widget.email,
                      otp: otp,
                    );

                    if (success) {
                      Get.off(() => const WelcomeScreen());
                    }
                  },
                  child: driverLoginController.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Verify OTP",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
