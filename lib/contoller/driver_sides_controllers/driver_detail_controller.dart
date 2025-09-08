import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_constants.dart';

class DriverDetailController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final codeController = TextEditingController(); // For OTP input
  final codeFocusNode = FocusNode();
  final scrollController = ScrollController();

  // Observables
  var code = ''.obs;
  var isLoading = false.obs;

  bool get isCodeValid => code.value.length == 6;

  /// Register driver API
  Future<bool> registerDriver({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      isLoading.value = true;

      final url = Uri.parse(ApiConstants.registerDriver);

      final body = jsonEncode({
        "name": name,
        "email": email,
        "phone": phone,
      });

      print("🔵 [RegisterDriver] Calling API: $url");
      print("🔵 [RegisterDriver] Body: $body");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("🔵 [RegisterDriver] Response Code: ${response.statusCode}");
      print("🔵 [RegisterDriver] Raw Response Body: ${response.body}");

      dynamic decoded;
      try {
        decoded = jsonDecode(response.body);
      } catch (_) {
        Get.snackbar("Error", "Invalid response from server");
        return false;
      }

      if (response.statusCode == 201 && decoded["success"] == true) {
        final driverId = decoded["data"]["id"];
        print("✅ [RegisterDriver] Driver ID received: $driverId");

        /// Save driverId in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("driver_id", driverId);

        print("🔑 Driver ID saved in SharedPreferences");

        Get.snackbar("Success", decoded["message"]);
        return true;
      } else {
        print("❌ [RegisterDriver] Failed: $decoded");
        Get.snackbar("Error", decoded["message"] ?? "Failed to register driver");
        return false;
      }
    } catch (e) {
      print("🔥 Exception in registerDriver: $e");
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    codeController.dispose();
    codeFocusNode.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
