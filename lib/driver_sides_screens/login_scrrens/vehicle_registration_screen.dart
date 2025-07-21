import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';
import 'driver_dashboard_screen.dart';
class VehicleRegistrationScreen extends StatelessWidget {
  final List<String> selectedServices;

  const VehicleRegistrationScreen({super.key, required this.selectedServices});


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
            _inputCard('Vehicle details',
                [
              _dropdownField('Vehicle type', ['Auto Rickshaw', 'Bike', 'Car']),
              const SizedBox(height: 12),
              _textField('Vehicle number', 'JH098212'),
              _textField('Owner name', 'Akshay Kumar'),
            ]),

            _inputCard('Selected Services', [
              Wrap(
                spacing: 10,
                children: selectedServices
                    .map((service) => Chip(
                  label: Text(
                    service,
                    style: TextStyle(color: AppColors.white),
                  ),
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
              _uploadTile('Upload driving license'),
              _uploadTile('Upload RC (Registration Certificate)'),
              _uploadTile('Upload vehicle insurance'),
            ]),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const VerificationSubmittedScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.skyBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:  Text('Submit for verification', style: TextStyle(color: AppColors.white,fontSize: 16)),
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
          SizedBox(height: 20,),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.graybg.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: items.first,
            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.gray.withOpacity(0.6)),
            style: TextStyle(color: AppColors.black), // 👈 selected item text color
            dropdownColor: Colors.white,
            items: items
                .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                style: TextStyle(color: AppColors.black), // 👈 dropdown list text color
              ),
            ))
                .toList(),
            onChanged: (value) {},
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }

  Widget _textField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.graybg.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _uploadTile(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
                   Icon(Icons.cloud_download_outlined, color: AppColors.black),
                  const SizedBox(width: 15  ),

                  Text(title),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
