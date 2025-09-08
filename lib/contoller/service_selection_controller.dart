import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/service_selection_model.dart';
import 'api_constants.dart';

class ServiceController extends GetxController {
  var services = <ServiceModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadServices();
  }

  void loadServices() {
    services.value = [
      ServiceModel(
        id: 'ride',
        title: 'Passenger Rides',
        subtitle: 'Transport passengers to their destinations',
        icon: 'directions_car',
      ),
      ServiceModel(
        id: 'courier',
        title: 'Package Delivery',
        subtitle: 'Deliver packages and documents',
        icon: 'delivery_dining',
      ),
      ServiceModel(
        id: 'freight',
        title: 'Goods Transport',
        subtitle: 'Transport goods and heavy items',
        icon: 'all_inbox',
      ),
    ];
  }

  void toggleService(String id) {
    services.value = services.map((service) {
      if (service.id == id) {
        return service.copyWith(isSelected: !service.isSelected);
      }
      return service;
    }).toList();
  }

  Future<void> submitServices() async {
    isLoading.value = true;

    final selected = services.where((s) => s.isSelected).map((s) => s.id).toList();

    if (selected.isEmpty) {
      Get.snackbar("Error", "Please select at least one service");
      isLoading.value = false;
      return;
    }

    try {
      final url = Uri.parse(ApiConstants.profile);
      final body = jsonEncode({'services': selected});

      print("🔵 URL: $url");
      print("🔵 Body: $body");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'}, // No token here
        body: body,
      );

      print("🔵 Status Code: ${response.statusCode}");
      print("🔵 Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        Get.snackbar("Success", "Services updated successfully");
      } else {
        Get.snackbar("Error", data['message'] ?? "Failed to update services");
      }
    } catch (e) {
      print("🔥 Exception: $e");
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
