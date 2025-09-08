import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vezoh_driver/screens/driver_sides_screens/order_screens/tripin_progress_screen.dart';

import '../../../theme/app_theme.dart';


class DrivetoPickuprideScreen extends StatefulWidget {
  const DrivetoPickuprideScreen({super.key});

  @override
  State<DrivetoPickuprideScreen> createState() =>
      _DrivetoPickuprideScreenState();
}

class _DrivetoPickuprideScreenState extends State<DrivetoPickuprideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.skyBlue,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Drive to pickup',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top card with location icon and text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray, width: 0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.skyBlue,
                    child: Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Navigate to pickup location',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Koramangala 5th Block ',
                    style: TextStyle(fontSize: 14, color: AppColors.gray),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.graybg.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Text(
                      '3 min away',
                      style: TextStyle(color: AppColors.black),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Bottom card with user details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray, width: 0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row with avatar and actions
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColors.skyBlue,
                        radius: 22,
                        child: Text(
                          'JD',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('+91 98765 43210'),
                          ],
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.3,color: AppColors.gray),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.call),
                        ),
                      ),
              SizedBox(width: 5,),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.3,color: AppColors.gray),
                ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chat_bubble_outline),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Pickup instruction
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cyan.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '📍 Near the coffee shop at Gate 2',
                      style: TextStyle(color: AppColors.skyBlue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // ✅ Package Collected Button (Green)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Get.to(TripinProgressScreen()); // 👈 Use GetX to go back
                },
                child: const Text(
                  'Package collected',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ✅ Cancel Trip Button (Outlined Red)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.red,
                  side: const BorderSide(color: AppColors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Get.back(); // 👈 Use GetX to go back
                },
                child: const Text('Cancel trip'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
