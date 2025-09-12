import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vezoh_driver/theme/app_theme.dart';
import '../../../contoller/service_selection_controller.dart';
import '../../../model/service_selection_model.dart';

class ServiceSelectionScreen extends StatelessWidget {
  const ServiceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ServiceController controller = Get.put(ServiceController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        backgroundColor: AppColors.skyBlue,
        title: const Text('Service Selection', style: TextStyle(color: Colors.white)),
      ),
      body: Obx(() => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 12),
          Center(child: const Text('Choose your services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 8),
          const Text(
            'Select which services you want to offer with your vehicle',
            style: TextStyle(fontSize: 14, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ...controller.services.map((service) => _serviceOption(controller, service)).toList(),
          // Multi-service benefits tile with title, subtitle, and trailing icon
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: const Text(
                "Multi-Service Benefits",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              subtitle: const Text(
                "Get more benefits and maximize your earnings",
                style: TextStyle(fontSize: 14, color: Colors.green),
              ),
              leading: const Icon(Icons.info_outline, color: Colors.green, size: 32),
            ),
          ),

          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.skyBlue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: controller.isLoading.value
                  ? null
                  : () {

                controller.submitServices(); // ✅ No token
              },
              child: controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Continue Registration', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      )),
    );
  }

  Widget _serviceOption(ServiceController controller, ServiceModel service) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => controller.toggleService(service.id),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: service.isSelected ? Colors.white : AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: service.isSelected ? AppColors.skyBlue : AppColors.gray,
              width: service.isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                value: service.isSelected,
                onChanged: (_) => controller.toggleService(service.id),
                activeColor: AppColors.skyBlue,
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: _getServiceColor(service.id), // ✅ Dynamic color
                child: Icon(_getIconData(service.icon), color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(service.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(service.subtitle, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Helper method to assign colors based on service
  Color _getServiceColor(String serviceId) {
    switch (serviceId) {
      case 'ride':
        return AppColors.skyBlue;
      case 'courier':
        return AppColors.orange;
      case 'freight':
        return AppColors.green;
      default:
        return AppColors.gray;
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'directions_car':
        return Icons.directions_car;
      case 'delivery_dining':
        return Icons.delivery_dining;
      case 'all_inbox':
        return Icons.all_inbox;
      default:
        return Icons.help_outline;
    }
  }
}
