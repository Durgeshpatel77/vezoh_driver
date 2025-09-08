import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vezoh_driver/screens/driver_sides_screens/verification_screens/service_selation_screen.dart';

import '../../../theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.white,// sky blue

      appBar: AppBar(
          backgroundColor:  AppColors.skyBlue,// sky blue
        title: const Text(
          'Welcome to Vezoh',
          style: TextStyle(color: AppColors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white, size: 20),
          onPressed: () {
            Get.back();
          },
        ),

        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundColor:  AppColors.skyBlue,// sky blue
              child: const Icon(
                Icons.network_cell,
                color:AppColors.white,// sky blue
                size: 30,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Drive and earn',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Make money on your schedule with your own vehicle.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color:AppColors.skyBlue,// sky blue
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(() => const ServiceSelectionScreen());
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: 16,
                          color:AppColors.white,// sky blue
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Benefits Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.gray,width: 0.3)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Why drive with Vezoh?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),

                  _benefitItem(
                    bgColor: Colors.greenAccent.withOpacity(0.2),
                    icon: Icons.currency_rupee,
                    iconColor: Colors.green,
                    text: 'Earn up to ₹25,000 per month',
                  ),
                  const SizedBox(height: 12),

                  _benefitItem(
                    bgColor: Colors.blueAccent.withOpacity(0.2),
                    icon: Icons.access_time,
                    iconColor: Colors.blue,
                    text: 'Flexible working hours',
                  ),
                  const SizedBox(height: 12),

                  _benefitItem(
                    bgColor: Colors.purpleAccent.withOpacity(0.2),
                    icon: Icons.flash_on,
                    iconColor: Colors.purple,
                    text: 'Daily payouts',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _benefitItem({
    required Color bgColor,
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: bgColor,
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
