import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../contoller/driver_sides_controllers/online_status_controller.dart';
import '../../../theme/app_theme.dart';
import '../profile_screen.dart';
import 'earning_screens.dart';
import '../order_screens/incoming_requests_screen.dart';

class VerificationSubmittedScreen extends StatefulWidget {
  const VerificationSubmittedScreen({super.key});

  @override
  State<VerificationSubmittedScreen> createState() =>
      _VerificationSubmittedScreenState();
}

class _VerificationSubmittedScreenState
    extends State<VerificationSubmittedScreen> {
  bool isOnline = false;
  final controller = Get.put(OnlineStatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.graybg,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: AppColors.skyBlue),
                child: Row(
                  children: const [
                    Icon(Icons.person, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Hello, User",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                title: const Text('Earnings'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: AppColors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
              onPressed: () => Get.to(() => const ProfileScreen()),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final controller = Get.put(OnlineStatusController()); // ✅ initialize controller here

          return SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxHeight: screenHeight * 0.63),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                              // ✅ Status Card
                              Obx(() => Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.gray, width: 0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("You are", style: TextStyle(color: AppColors.gray)),
                                            const SizedBox(height: 4),
                                            Text(
                                              controller.isOnline.value ? "Online" : "Offline",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: controller.isOnline.value
                                                    ? Colors.green
                                                    : AppColors.gray,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Transform.scale(
                                              scale: 0.75,
                                              child: CupertinoSwitch(
                                                value: controller.isOnline.value,
                                                inactiveThumbColor: Colors.white,
                                                activeColor: Colors.green,
                                                onChanged: controller.toggleOnline,
                                              ),
                                            ),
                                            Text(
                                              controller.isOnline.value ? "Go offline" : "Go online",
                                              style: TextStyle(fontSize: 12, color: AppColors.gray),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    if (!controller.isOnline.value) ...[
                                      const Text(
                                        "Go online to start receiving requests",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 8,
                                        children: [
                                          _chipBox("Ride"),
                                          _chipBox("Courier"),
                                        ],
                                      ),
                                    ] else
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Row(
                                          children: [
                                            Icon(Icons.search, color: Colors.green, size: 18),
                                            SizedBox(width: 10),
                                            Flexible(
                                              child: Text(
                                                "Looking for requests across 2 services...",
                                                style: TextStyle(fontSize: 14, color: Colors.green),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              )),


                              const SizedBox(height: 20),

                                // ✅ Earnings & Trips
                                Row(
                                  children: [
                                    _infoTile("₹1250", "Today's earnings"),
                                    const SizedBox(width: 12),
                                    _infoTile("8", "Trips completed"),
                                  ],
                                ),

                                const SizedBox(height: 20),

                                // ✅ Vehicle Card
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.gray,
                                      width: 0.4,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Your vehicle",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade50,
                                              borderRadius: BorderRadius.circular(
                                                12,
                                              ),
                                            ),
                                            child: const Text(
                                              "Active",
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 22,
                                            backgroundColor: AppColors.skyBlue,
                                            child: const Text(
                                              '🛺',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Auto",
                                                  style: TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  "JH098212",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: AppColors.gray,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            right: 4,
                                                          ),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 6,
                                                              vertical: 2,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.white,
                                                          border: Border.all(
                                                            color: AppColors.gray,
                                                            width: 0.4,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          "ride",
                                                          style: TextStyle(
                                                            fontSize: 8,
                                                            color:
                                                                AppColors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 6,
                                                            vertical: 2,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.white,
                                                        border: Border.all(
                                                          color: AppColors.gray,
                                                          width: 0.4,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        "courier",
                                                        style: TextStyle(
                                                          fontSize: 8,
                                                          color: AppColors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // ✅ Bottom Button stays fixed at bottom
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => const EarningsScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.skyBlue,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "View earnings",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
  }

  // Info Tile Widget
  Widget _infoTile(String title, String subtitle) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43, // 45% of screen width
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray, width: 0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, color: AppColors.skyBlue),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: AppColors.gray),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Chip-style Container
  Widget _chipBox(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.gray.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}
