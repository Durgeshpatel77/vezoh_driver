import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vezoh_driver/driver_sides_screens/login_scrrens/welcome_screen.dart';

import '../../contoller/driver_sides_controllers/signup_driver_controller.dart';
import '../../theme/app_theme.dart';

class SignupDriverScreen extends StatefulWidget {
  const SignupDriverScreen({super.key});

  @override
  State<SignupDriverScreen> createState() => _SignupDriverScreenState();
}

class _SignupDriverScreenState extends State<SignupDriverScreen> {
  final SignupDriverController controller = Get.put(SignupDriverController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.skyBlue,
        title: const Text(
          'Sign up to drive',
          style: TextStyle(color: AppColors.white, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white, size: 20),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Start earning with Vezoh',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Enter your phone number to get started",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Phone number', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: '+91 98765 43210',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Continue Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.skyBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  FocusScope.of(context).requestFocus(controller.codeFocusNode);
                  controller.scrollController.animateTo(
                    controller.scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                const Expanded(
                  child: Divider(
                    thickness: 1,
                    color: AppColors.gray,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: AppColors.gray,
                    ),
                  ),
                ),
                 Expanded(
                  child: Divider(
                    thickness: 1,
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Verification Code', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: controller.codeController,
                focusNode: controller.codeFocusNode,
                keyboardType: TextInputType.number,
                maxLength: 6,
                buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                onChanged: (value) {
                  controller.code.value = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter 6 digit code',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Verify Code Button
            Obx(() {
              final isEnabled = controller.isCodeValid;

              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isEnabled ? AppColors.skyBlue : AppColors.skylite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: isEnabled
                      ? () {
                    Get.to(() => WelcomeScreen());
                  }
                      : null,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'Verify',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
