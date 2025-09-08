import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vezoh_driver/screens/driver_sides_screens/order_screens/trip_completed_screen.dart';

import '../../../theme/app_theme.dart';


class TripinProgressScreen extends StatefulWidget {
  const TripinProgressScreen({super.key});

  @override
  State<TripinProgressScreen> createState() => _TripinProcessScreenState();
}

class _TripinProcessScreenState extends State<TripinProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.skyBlue,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Trip in progress',
          style: TextStyle(color: AppColors.white),
        ),
      ),
backgroundColor: AppColors.white,
      body:
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
                    backgroundColor: AppColors.green,
                    child: Icon(
                      Icons.check,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Passenger on board',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Navigate to destination',
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
                      '25 min remaining',
                      style: TextStyle(color: AppColors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Destination Info Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.gray, width: 0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Destination", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.circle, size: 14, color: AppColors.red),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "MG Road Metro Station",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "8.5 km away",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.gray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ✅ Trip Progress Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.gray, width: 0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Trip progress", style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("60%", style: TextStyle(color: AppColors.gray)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: LinearProgressIndicator(
                      value: 0.6,
                      minHeight: 8,
                      color: AppColors.black,
                      backgroundColor: AppColors.gray.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Started", style: TextStyle(fontSize: 12, color: AppColors.gray)),
                      Text("In progress", style: TextStyle(fontSize: 12, color: AppColors.gray)),
                      Text("Complete", style: TextStyle(fontSize: 12, color: AppColors.gray)),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Complete Trip Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const TripCompletedScreen());                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Complete trip", style: TextStyle(color: AppColors.white)),
              ),
            ),

            const SizedBox(height: 16),

            // ✅ Bottom Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Call passenger
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: AppColors.gray, width: 0.5),
                    ),
                    icon: const Icon(Icons.call, color: AppColors.black),
                    label: const Text("Call passenger", style: TextStyle(color: AppColors.black)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Emergency action
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: AppColors.gray, width: 0.5),
                    ),
                    icon: const Icon(Icons.warning_rounded, color: AppColors.red),
                    label: const Text("Emergency", style: TextStyle(color: AppColors.red)),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
