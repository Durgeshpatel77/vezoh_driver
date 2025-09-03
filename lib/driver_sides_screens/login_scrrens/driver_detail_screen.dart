import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vezoh_driver/driver_sides_screens/login_scrrens/signup_password_screen.dart';
import '../../contoller/driver_sides_controllers/driver_detail_controller.dart';
import '../../theme/app_theme.dart';

class DriverDetailScreen extends StatefulWidget {
  const DriverDetailScreen({super.key});

  @override
  State<DriverDetailScreen> createState() => _SignupDriverScreenState();
}

class _SignupDriverScreenState extends State<DriverDetailScreen> {
  final DriverDetailController controller = Get.put(DriverDetailController());
  final _formKey = GlobalKey<FormState>(); // Form key

  InputDecoration customInputDecoration(String hint) {
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

  // Email validator
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  // Phone validator
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    if (value.length != 10) return 'Enter a 10-digit number';
    return null;
  }

  // Name validator
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
        title: const Text(
          'Get started',
          style: TextStyle(color: AppColors.white, fontSize: 18),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
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
                 Center(
                  child: Column(
                    children: [
                      Container(
                        height:60,
                       width: 60,
                       decoration: BoxDecoration(color: AppColors.skyBlue,borderRadius: BorderRadius.circular(10)),
                       child: Center(
                         child: Text(
                            "V",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                       ),
                      ),
                      Text("vezoH", style: TextStyle(fontSize: 16, color: AppColors.skyBlue)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Tell us about yourself",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 20),

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
                      const Text('Full Name'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.nameController,
                        decoration: customInputDecoration('John Doe'),
                        validator: _validateName,
                      ),
                      const SizedBox(height: 16),
                      const Text('Email Address'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: customInputDecoration('johndoe@gmail.com'),
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 16),
                      const Text('Phone Number'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: customInputDecoration('9865123445'),
                        validator: _validatePhone,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // All fields are valid
                        Get.to(() => const SignupPasswordScreen());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.skyBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Continue to Password Setup',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, size: 10, color: AppColors.skyBlue),
                          SizedBox(width: 6),
                          Icon(Icons.circle_outlined, size: 10, color: Colors.grey),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text("Step 1 of 2", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
