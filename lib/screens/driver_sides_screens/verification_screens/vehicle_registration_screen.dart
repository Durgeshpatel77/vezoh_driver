import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../contoller/driver_sides_controllers/vehicle_registration_controller.dart';
import '../../../theme/app_theme.dart';

class VehicleRegistrationScreen extends StatelessWidget {
  final List<String> selectedServices;
  final VehicleRegistrationController controller = Get.put(VehicleRegistrationController());

  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final RxString selectedVehicleType = 'Auto Rickshaw'.obs;

  VehicleRegistrationScreen({super.key, required this.selectedServices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.skyBlue,
        title: const Text('Vehicle registration', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _inputCard('Vehicle details', [
              _dropdownField('Vehicle type', ['Auto Rickshaw', 'Bike', 'Car']),
              const SizedBox(height: 12),
              _textFieldInput('Vehicle number', vehicleNumberController, 'JH098212'),
              _textFieldInput('Owner name', ownerNameController, 'Akshay Kumar'),
            ]),
            _inputCard('Selected Services', [
              Wrap(
                spacing: 10,
                children: selectedServices
                    .map((service) => Chip(
                  label: Text(service, style: TextStyle(color: AppColors.white)),
                  backgroundColor: AppColors.skyBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none,
                  ),
                ))
                    .toList(),
              ),
            ]),
            _inputCard('Upload documents', [
              _uploadTile('Upload driving license', controller.drivingLicense),
              _uploadTile('Upload RC (Registration Certificate)', controller.rcCertificate),
              _uploadTile('Upload vehicle insurance', controller.vehicleInsurance),
            ]),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Call controller submitVehicle
                  await controller.submitVehicle(
                    vehicleType: selectedVehicleType.value,
                    vehicleNumber: vehicleNumberController.text.trim(),
                    ownerName: ownerNameController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.skyBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Submit for verification',
                    style: TextStyle(color: AppColors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 22),
          ...children,
        ],
      ),
    );
  }

  Widget _dropdownField(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.graybg.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedVehicleType.value,
            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.gray.withOpacity(0.6)),
            style: TextStyle(color: AppColors.black),
            dropdownColor: Colors.white,
            items: items
                .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e, style: TextStyle(color: AppColors.black)),
            ))
                .toList(),
            onChanged: (value) {
              if (value != null) selectedVehicleType.value = value;
            },
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        )),
      ],
    );
  }

  Widget _textFieldInput(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.graybg.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _uploadTile(String title, Rx<XFile?> file) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: InkWell(
          onTap: () => controller.pickDocument(title),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.cloud_upload_outlined, color: AppColors.black),
                      const SizedBox(width: 15),
                      Expanded(child: Text(title)),
                      if (file.value != null) const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class VerificationSubmittedScreen extends StatelessWidget {
  const VerificationSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Verification Submitted")),
    );
  }
}
