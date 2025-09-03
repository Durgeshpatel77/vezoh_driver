import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vezoh_driver/driver_sides_screens/verification_screens/vehicle_registration_screen.dart';

import '../../theme/app_theme.dart';

class ServiceSelectionScreen extends StatefulWidget {
  const ServiceSelectionScreen({super.key});

  @override
  State<ServiceSelectionScreen> createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends State<ServiceSelectionScreen> {
  // Track selections
  bool passengerRides = true;
  bool packageDelivery = true;
  bool goodsTransport = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white, size: 20),
          onPressed: () {
            Get.back();
          },
        ),

        backgroundColor:AppColors.skyBlue,// sky blue
        title:  Text('Service Selection',style: TextStyle(color: AppColors.white),),
        scrolledUnderElevation: 0,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                'Choose your services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select which services you want to offer with your vehicle',
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
        
              // Service options
              _serviceOption(
                isSelected: passengerRides,
                onTap: () => setState(() => passengerRides = !passengerRides),
                title: 'Passenger Rides',
                subtitle: 'Transport passengers to their destinations',
                icon: Icons.directions_car,
                iconColor: Colors.blue,
              ),
              const SizedBox(height: 12),
        
              _serviceOption(
                isSelected: packageDelivery,
                onTap: () => setState(() => packageDelivery = !packageDelivery),
                title: 'Package Delivery',
                subtitle: 'Deliver packages and documents',
                icon: Icons.delivery_dining,
                iconColor: Colors.orange,
              ),
              const SizedBox(height: 12),
        
              _serviceOption(
                isSelected: goodsTransport,
                onTap: () => setState(() => goodsTransport = !goodsTransport),
                title: 'Goods Transport',
                subtitle: 'Transport goods and heavy items',
                icon: Icons.all_inbox,
                iconColor: Colors.green,
              ),
              const SizedBox(height: 20),
        
              // Benefits box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: Colors.green),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Multi-Service Benefits',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Get more requests and maximize your earnings!',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        
        SizedBox(height: 30,),
              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.skyBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    final selectedServices = [
                      if (passengerRides) 'Ride',
                      if (packageDelivery) 'Courier',
                      if (goodsTransport) 'Goods',
                    ];
        
                    Get.to(() => VehicleRegistrationScreen(selectedServices: selectedServices));
                  },
                  child: const Text(
                    'Continue Registration',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceOption({
    required bool isSelected,
    required VoidCallback onTap,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.skyBlue : AppColors.gray.withOpacity(0.3),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                value: isSelected,
                onChanged: (_) => onTap(),
                activeColor: AppColors.skyBlue,
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: iconColor,
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
