import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import 'driver_dashboard_screen.dart';
import 'incoming_requests_screen.dart';

class TripCompletedScreen extends StatelessWidget {
  const TripCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.skyBlue,
        title: const Text(
          'Trip completed',
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ✅ Success Message Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray, width: 0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                   CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.green.withOpacity(0.2),
                    child: Icon(
                      Icons.check,
                      color: AppColors.green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Well done!',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Trip completed successfully',
                    style: TextStyle(fontSize: 14, color: AppColors.gray),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Trip Summary Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray, width: 0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Trip summary', style: TextStyle(fontWeight: FontWeight.w900,color: AppColors.black,fontSize: 16)),
                  const SizedBox(height: 14),

                  _summaryRow('Distance', '8.5 km',valueColor: AppColors.gray),
                  const SizedBox(height: 6),
                  _summaryRow('Duration', '28 min',valueColor: AppColors.gray),
                  const Divider(height: 24),
                  _summaryRow('Trip fare', '₹160', valueColor: AppColors.skyBlue),
                  _summaryRow('Commission (15%)', '-₹24', valueColor: AppColors.red),
                  _summaryRow('Your earnings', '₹136', valueColor: AppColors.green),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Rating Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.gray, width: 0.3),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Passenger rating", style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                      Icon(Icons.star, color: Colors.amber),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '"Great driver, safe trip!"',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),

SizedBox(height: 30,),
            // ✅ Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
          Get.to(() => const VerificationSubmittedScreen()),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black12),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Go offline', style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Go to next screen (example)
                      Get.to(() => const IncomingRequestsPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Find next trip', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {Color valueColor = Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value, style: TextStyle(color: valueColor)),
      ],
    );
  }
}
