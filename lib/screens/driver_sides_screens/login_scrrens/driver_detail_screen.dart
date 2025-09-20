import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vezoh_driver/screens/driver_sides_screens/login_scrrens/sign_in_screen.dart';
import '../../../contoller/driver_sides_controllers/driver_detail_controller.dart';
import '../../../theme/app_theme.dart';
import 'driver_otp_screen.dart';

class DriverDetailScreen extends StatefulWidget {
  const DriverDetailScreen({super.key});

  @override
  State<DriverDetailScreen> createState() => _DriverDetailScreenState();
}

class _DriverDetailScreenState extends State<DriverDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(DriverDetailController());

  InputDecoration customInputDecoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: const Color(0xFFF5F5F5),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    if (value.length != 10) return 'Enter a 10-digit number';
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.skyBlue,
        centerTitle: true,
        title: const Text(
          "Complete your profile",
          style: TextStyle(color: AppColors.white, fontSize: 18),
        ),
        leading: const BackButton(color: AppColors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
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
                      const Text(
                        "vezoH",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Tell us about yourself",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 20),
                Text(
                  "We need a few details to personalize your experience",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColors.gray,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                /// Form fields
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 0.4, color: AppColors.gray),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Full Name'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.nameController,
                        validator: _validateName,
                        decoration: customInputDecoration('John Doe'),
                      ),
                      const SizedBox(height: 16),
                      const Text('Email Address'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.emailController,
                        validator: _validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: customInputDecoration('johndoe@gmail.com'),
                      ),
                      const SizedBox(height: 16),
                      const Text('Phone Number'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.phoneController,
                        validator: _validatePhone,
                        keyboardType: TextInputType.phone,
                        decoration: customInputDecoration('9865123445'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                /// Continue button
                Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                      if (_formKey.currentState!.validate()) {
                        final success =
                        await controller.registerDriver(
                          name:
                          controller.nameController.text.trim(),
                          email: controller.emailController.text
                              .trim(),
                          phone: controller.phoneController.text
                              .trim(),
                        );

                        if (success) {
                          Get.to(() => DriverOtpScreen(email: controller.emailController.text));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.skyBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : const Text(
                      'Continue to Password Setup',
                      style: TextStyle(
                          color: Colors.white, fontSize: 16),
                    ),
                  ),
                )),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: () {
                    // 👉 Navigate to Sign In Screen
                    Get.to(() => const SignInScreen());
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: AppColors.gray, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: TextStyle(
                            color: AppColors.skyBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

            ],
            ),
          ),
        ),
      ),
    );
  }
}
