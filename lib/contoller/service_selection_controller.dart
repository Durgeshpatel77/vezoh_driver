import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/service_selection_model.dart';
import '../screens/driver_sides_screens/verification_screens/vehicle_registration_screen.dart';
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

  /// Correct toggle: only update the specific service
  void toggleService(String id) {
    final index = services.indexWhere((s) => s.id == id);
    if (index != -1) {
      services[index] = services[index].copyWith(
        isSelected: !services[index].isSelected,
      );
    }
  }

  Future<void> submitServices() async {
    isLoading.value = true;

    // Get the list of selected services (full objects)
    final selectedServices = services.where((s) => s.isSelected).toList();

    if (selectedServices.isEmpty) {
      Get.snackbar("Error", "Please select at least one service");
      isLoading.value = false;
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("auth_token") ?? "";

      final url = Uri.parse("https://vizoh-app.onrender.com/api/driver/opt-services");
      final body = jsonEncode({'services': selectedServices.map((s) => s.id).toList()});

      print("🔵 URL: $url");
      print("🔵 Body: $body");
      print("🔑 Token: $token");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      print("🔵 Status Code: ${response.statusCode}");
      print("🔵 Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        Get.snackbar("Success", data['message'] ?? "Services registered successfully");

        // ✅ Corrected navigation with list of service IDs
        Get.off(() => VehicleRegistrationScreen(
            selectedServices: selectedServices.map((s) => s.id).toList()
        ));

      } else {
        Get.snackbar("Error", data['message'] ?? "Failed to register services");
      }
    } catch (e) {
      print("🔥 Exception: $e");
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
