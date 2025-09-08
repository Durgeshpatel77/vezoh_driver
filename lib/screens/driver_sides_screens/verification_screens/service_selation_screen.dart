import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        backgroundColor: Colors.blue,
        title: const Text('Service Selection', style: TextStyle(color: Colors.white)),
      ),
      body: Obx(() => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 12),
          const Text('Choose your services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'Select which services you want to offer with your vehicle',
            style: TextStyle(fontSize: 14, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ...controller.services.map((service) => _serviceOption(controller, service)).toList(),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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
            color: service.isSelected ? Colors.white : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: service.isSelected ? Colors.blue : Colors.grey.withOpacity(0.3),
              width: service.isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Checkbox(
                value: service.isSelected,
                onChanged: (_) => controller.toggleService(service.id),
                activeColor: Colors.blue,
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.blue,
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
