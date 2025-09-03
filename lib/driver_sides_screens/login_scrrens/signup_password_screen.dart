import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vezoh_driver/driver_sides_screens/verification_screens/welcome_screen.dart';
import '../../contoller/driver_sides_controllers/driver_detail_controller.dart';
import '../../theme/app_theme.dart';
import '../home_screens/driver_dashboard_screen.dart';

class SignupPasswordScreen extends StatefulWidget {
  const SignupPasswordScreen({super.key});

  @override
  State<SignupPasswordScreen> createState() => _SignupPasswordScreenState();
}

class _SignupPasswordScreenState extends State<SignupPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final controller = Get.find<DriverDetailController>();
  bool get hasNumber => passwordController.text.contains(RegExp(r'[0-9]'));

  bool get isPasswordValid => passwordController.text.length >= 8;
  bool get isPasswordMatch =>
      passwordController.text == confirmPasswordController.text;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration passwordDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade400, width: 4),
      ),
    );
  }

  Widget _validationIndicator({required bool condition, required String text}) {
    return Row(
      children: [
        Icon(Icons.circle,
            size: 8, color: condition ? Colors.green : Colors.grey),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
              color: condition ? Colors.green : Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.skyBlue,
        title: const Text('Get started',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),

                // Logo and Heading
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: AppColors.skyBlue,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "V",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text("vezoH",
                          style:
                          TextStyle(fontSize: 16, color: AppColors.skyBlue)),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                const Text(
                  "Please set your password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 24),

                // User Info
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.skyBlue, width: 0.6),
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.skyBlue.withOpacity(0.1)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Text(
                          controller.nameController.text.isNotEmpty
                              ? controller.nameController.text[0].toUpperCase()
                              : '',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.nameController.text,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(controller.emailController.text,
                              style:
                              const TextStyle(fontSize: 14, color: Colors.grey)),
                          Text(controller.phoneController.text,
                              style:
                              const TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Password Fields
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 0.4, color: AppColors.gray),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('Create Password',style: TextStyle(fontSize: 16,color: AppColors.black),),
SizedBox(height: 20,),
                      const Text('Password'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: passwordDecoration('........'),
                        onChanged: (_) => setState(() {}),
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "*Password should be 8 letters",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),

                      const Text('Retype your password'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: passwordDecoration('........'),
                        onChanged: (_) => setState(() {}),
                        validator: (value) {
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Validation UI
                  // Validation UI
                  _validationIndicator(
                      condition: isPasswordValid,
                      text: "At least 8 characters"),
                  const SizedBox(height: 6),
                  _validationIndicator(
                      condition: isPasswordMatch,
                      text: "Passwords match"),
                ],
                  ),
                ),

                const SizedBox(height: 30),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Navigate to VerificationSubmittedScreen
                        Get.to(() => const WelcomeScreen());

                        // Show success snackbar
                        Get.snackbar(
                          "Success",
                          "Account created!",
                          backgroundColor: Colors.green.withOpacity(0.7),
                          colorText: Colors.white,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.skyBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Create Account',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),

                const SizedBox(height: 20),

                // Step Indicator
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.circle_outlined, size: 10, color: Colors.grey),
                    SizedBox(width: 6),
                    Icon(Icons.circle, size: 10, color: AppColors.skyBlue),
                  ],
                ),
                const SizedBox(height: 6),
                const Text("Step 2 of 2", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
