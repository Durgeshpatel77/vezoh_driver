import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../theme/app_theme.dart';
import '../home_screens/driver_dashboard_screen.dart';

class VehicleRegistrationScreen extends StatefulWidget {
  final List<String> selectedServices;

  const VehicleRegistrationScreen({super.key, required this.selectedServices});

  @override
  State<VehicleRegistrationScreen> createState() => _VehicleRegistrationScreenState();
}

class _VehicleRegistrationScreenState extends State<VehicleRegistrationScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _drivingLicense;
  XFile? _rcCertificate;
  XFile? _vehicleInsurance;

  Future<void> _pickDocument(String title) async {
    // Check current permission status
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus photosStatus = await Permission.photos.status;
    PermissionStatus storageStatus = await Permission.storage.status;

    bool isGranted = cameraStatus.isGranted &&
        (photosStatus.isGranted || storageStatus.isGranted);

    if (isGranted) {
      // Already granted → show options directly
      _showImageSourceOption(title);
      return;
    }

    // Request permission only if not granted
    final statuses = await [
      Permission.camera,
      Permission.photos,
      Permission.storage,
    ].request();

    bool grantedAfterRequest = statuses.values.every((status) => status.isGranted);
    bool permanentlyDenied = statuses.values.any((status) => status.isPermanentlyDenied);

    if (grantedAfterRequest) {
      // Permission granted → show modal
      _showImageSourceOption(title);
    } else if (permanentlyDenied) {
      // User denied permanently → open app settings
      Get.snackbar("Permission Required", "Please enable permissions from settings.");
      openAppSettings();
    } else {
      // User denied but not permanently → just show snackbar
      Get.snackbar("Permission Required", "You need to allow permissions to upload documents.");
    }
  }

// Modal to choose gallery or camera
  void _showImageSourceOption(String title) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.of(context).pop();
                await _pickImage(ImageSource.gallery, title);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.of(context).pop();
                await _pickImage(ImageSource.camera, title);
              },
            ),
          ],
        ),
      ),
    );
  }

// Pick image from gallery or camera
  Future<void> _pickImage(ImageSource source, String title) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          if (title == "Upload driving license") _drivingLicense = pickedFile;
          if (title == "Upload RC (Registration Certificate)") _rcCertificate = pickedFile;
          if (title == "Upload vehicle insurance") _vehicleInsurance = pickedFile;
        });
        Get.snackbar("Success", "$title uploaded successfully.");
      } else {
        Get.snackbar("Cancelled", "No file selected.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to upload $title: $e");
    }
  }


  Future<PermissionStatus> _requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.photos, // For iOS
      Permission.storage, // For Android < 13
    ].request();

    // Return granted if all permissions are granted, otherwise denied
    if (statuses.values.every((status) => status.isGranted)) {
      return PermissionStatus.granted;
    } else if (statuses.values.any((status) => status.isPermanentlyDenied)) {
      return PermissionStatus.permanentlyDenied;
    } else {
      return PermissionStatus.denied;
    }
  }



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
              _textField('Vehicle number', 'JH098212'),
              _textField('Owner name', 'Akshay Kumar'),
            ]),
            _inputCard('Selected Services', [
              Wrap(
                spacing: 10,
                children: widget.selectedServices
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
              _uploadTile('Upload driving license', _drivingLicense),
              _uploadTile('Upload RC (Registration Certificate)', _rcCertificate),
              _uploadTile('Upload vehicle insurance', _vehicleInsurance),
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
            style: TextStyle(color: AppColors.black),
            dropdownColor: Colors.white,
            items: items
                .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e, style: TextStyle(color: AppColors.black)),
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

  Widget _uploadTile(String title, XFile? file) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () => _pickDocument(title),
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
                    if (file != null)
                      const Icon(Icons.check_circle, color: Colors.green),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationSubmittedScreen extends StatelessWidget {
  const VerificationSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Verification Submitted"),
      ),
    );
  }
}
