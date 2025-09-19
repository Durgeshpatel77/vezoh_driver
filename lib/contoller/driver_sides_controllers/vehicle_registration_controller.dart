import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/driver_sides_screens/home_screens/driver_dashboard_screen.dart';
import '../../screens/driver_sides_screens/home_screens/under_rieview_screen.dart';

class VehicleRegistrationController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  var drivingLicense = Rx<XFile?>(null);
  var rcCertificate = Rx<XFile?>(null);
  var vehicleInsurance = Rx<XFile?>(null);
  var isLoading = false.obs;

  Future<void> pickDocument(String title) async {
    bool granted = await _checkPermissions();
    if (granted) {
      _showImageSourceOption(title);
    } else {
      Get.snackbar("Permission Required", "Please enable permissions from settings.");
      openAppSettings();
    }
  }

  Future<bool> _checkPermissions() async {
    var cameraStatus = await Permission.camera.status;
    var photosStatus = await Permission.photos.status;
    var storageStatus = await Permission.storage.status;

    if (cameraStatus.isGranted && (photosStatus.isGranted || storageStatus.isGranted)) {
      return true;
    }

    final statuses = await [Permission.camera, Permission.photos, Permission.storage].request();
    return statuses.values.every((status) => status.isGranted);
  }

  void _showImageSourceOption(String title) {
    Get.bottomSheet(
      SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Get.back();
                await _pickImage(ImageSource.gallery, title);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Get.back();
                await _pickImage(ImageSource.camera, title);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<void> _pickImage(ImageSource source, String title) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        switch (title) {
          case "Upload driving license":
            drivingLicense.value = pickedFile;
            break;
          case "Upload RC (Registration Certificate)":
            rcCertificate.value = pickedFile;
            break;
          case "Upload vehicle insurance":
            vehicleInsurance.value = pickedFile;
            break;
        }
        Get.snackbar("Success", "$title uploaded successfully.");
      } else {
        Get.snackbar("Cancelled", "No file selected.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to upload $title: $e");
    }
  }


  /// ✅ Check service status after vehicle registration
  Future<void> checkServiceStatus(String? authToken) async {
    try {
      final url = Uri.parse("https://vizoh-app.onrender.com/api/driver/selected-services");
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $authToken"},
      );

      print("===== Selected Services Response =====");
      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");
      print("=====================================");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final serviceStatus = data['data']?['serviceStatus'] ?? "";

        if (serviceStatus == "pending") {
          Get.to(() =>  UnderReviewScreen()); // ⬅️ Replace with your actual Under Review screen
        } else {
          Get.offAll(() => const VerificationSubmittedScreen()); // ⬅️ Replace with your Dashboard screen
        }
      } else {
        Get.snackbar("Error", "Failed to fetch service status");
      }
    } catch (e) {
      print("Exception while checking service status: $e");
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> submitVehicle({
    required String vehicleType,
    required String vehicleNumber,
    required String ownerName,
  }) async {
    if (drivingLicense.value == null ||
        rcCertificate.value == null ||
        vehicleInsurance.value == null) {
      Get.snackbar("Error", "Please upload all documents");
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString("auth_token");
      final driverId = prefs.getString("driver_id");

      if (driverId == null) {
        Get.snackbar("Error", "Driver ID not found in SharedPreferences");
        print("Driver ID is null. SharedPreferences keys: ${prefs.getKeys()}");
        return;
      }

      print("Submitting vehicle...");
      print("Driver ID: $driverId");
      print("Auth Token: $authToken");
      print("Vehicle Type: $vehicleType");
      print("Vehicle Number: $vehicleNumber");
      print("Owner Name: $ownerName");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://vizoh-app.onrender.com/api/driver/register-vehicle"),
      );

      request.headers['Authorization'] = 'Bearer $authToken';
      request.fields['driverId'] = driverId;
      request.fields['vehicleType'] = vehicleType;
      request.fields['vehicleNumber'] = vehicleNumber;
      request.fields['ownerName'] = ownerName;

      request.files.add(await http.MultipartFile.fromPath(
          'drivingLicense', drivingLicense.value!.path));
      request.files.add(await http.MultipartFile.fromPath(
          'rcCertificate', rcCertificate.value!.path));
      request.files.add(await http.MultipartFile.fromPath(
          'vehicleInsurance', vehicleInsurance.value!.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("===== Vehicle Registration Response =====");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Body: ${response.body}");
      print("========================================");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          Get.snackbar("Success", data['message']);

          // ✅ After success, call selected-services API to check status
          await checkServiceStatus(authToken);
        } else {
          Get.snackbar("Error", data['message']);
        }
      } else {
        Get.snackbar(
            "Error", "Failed to submit. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred: $e");
      Get.snackbar("Error", e.toString());
    }
  }

  /// ✅ Check service status after vehicle registration
/* Future<void> submitVehicle({
    required String vehicleType,
    required String vehicleNumber,
    required String ownerName,
  }) async {
    if (drivingLicense.value == null ||
        rcCertificate.value == null ||
        vehicleInsurance.value == null) {
      Get.snackbar("Error", "Please upload all documents");
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString("auth_token"); // fetch token
      final driverId = prefs.getString("driver_id"); // ✅ correct key

      if (driverId == null) {
        Get.snackbar("Error", "Driver ID not found in SharedPreferences");
        print("Driver ID is null. SharedPreferences keys: ${prefs.getKeys()}");
        return;
      }

      print("Submitting vehicle...");
      print("Driver ID: $driverId");
      print("Auth Token: $authToken");
      print("Vehicle Type: $vehicleType");
      print("Vehicle Number: $vehicleNumber");
      print("Owner Name: $ownerName");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("https://vizoh-app.onrender.com/api/driver/register-vehicle"),
      );

      request.headers['Authorization'] = 'Bearer $authToken'; // include token
      request.fields['driverId'] = driverId;
      request.fields['vehicleType'] = vehicleType;
      request.fields['vehicleNumber'] = vehicleNumber;
      request.fields['ownerName'] = ownerName;

      request.files.add(await http.MultipartFile.fromPath(
          'drivingLicense', drivingLicense.value!.path));
      request.files.add(await http.MultipartFile.fromPath(
          'rcCertificate', rcCertificate.value!.path));
      request.files.add(await http.MultipartFile.fromPath(
          'vehicleInsurance', vehicleInsurance.value!.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("===== Vehicle Registration Response =====");
      print("Status Code: ${response.statusCode}");
      print("Headers: ${response.headers}");
      print("Body: ${response.body}");
      print("========================================");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['driverId'] != null) print("Driver ID (from response): ${data['driverId']}");
        if (data['vehicleId'] != null) print("Vehicle ID: ${data['vehicleId']}");
        if (data['success'] == true) {
          Get.snackbar("Success", data['message']);
          Get.to(() => const VerificationSubmittedScreen());
        } else {
          Get.snackbar("Error", data['message']);
        }
      } else {
        Get.snackbar(
            "Error", "Failed to submit. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred: $e");
      Get.snackbar("Error", e.toString());
    }
  }
*/
}
