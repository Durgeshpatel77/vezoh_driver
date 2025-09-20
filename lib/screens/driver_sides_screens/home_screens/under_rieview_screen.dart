import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vezoh_driver/theme/app_theme.dart';

class UnderReviewScreen extends StatefulWidget {
  const UnderReviewScreen({Key? key}) : super(key: key);

  @override
  State<UnderReviewScreen> createState() => _UnderReviewScreenState();
}

class _UnderReviewScreenState extends State<UnderReviewScreen> {
  String verificationStatus = "";
  List<String> services = [];
  String serviceStatus = "";

  @override
  void initState() {
    super.initState();
    fetchSelectedServices();
  }

  Future<void> fetchSelectedServices() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString("auth_token");

    try {
      final url = Uri.parse("https://vizoh-app.onrender.com/api/driver/selected-services");
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $authToken"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          verificationStatus = data['data']?['verificationStatus'] ?? "";
          services = List<String>.from(data['data']?['services'] ?? []);
          serviceStatus = data['data']?['serviceStatus'] ?? "";
        });
      } else {
        Get.snackbar("Error", "Failed to fetch services");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification", style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.skyBlue,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top card (status)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Column(
                children: [
                  Icon(
                    verificationStatus == "approved"
                        ? Icons.verified
                        : Icons.access_time,
                    size: 50,
                    color: verificationStatus == "approved"
                        ? Colors.green
                        : Colors.orange,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    verificationStatus == "approved"
                        ? "Approved"
                        : "Under Review",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    verificationStatus == "approved"
                        ? "Your documents are approved"
                        : "Your documents are being verified",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  if (verificationStatus != "approved")
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text("Usually takes 24-48 hours"),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Selected Services
            const Text("Selected Services",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            ...services.map((service) => Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(
                  service.toLowerCase() == "ride"
                      ? Icons.directions_car
                      : Icons.local_shipping,
                  color: Colors.blue,
                  size: 32,
                ),
                title: Text(service.capitalizeFirst ?? service),
                subtitle: Text(
                  service.toLowerCase() == "ride"
                      ? "Passenger transportation"
                      : "Package delivery",
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: serviceStatus == "active"
                        ? Colors.green.shade100
                        : Colors.yellow.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    serviceStatus.capitalizeFirst ?? "Pending",
                    style: TextStyle(
                      color: serviceStatus == "active"
                          ? Colors.green
                          : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
