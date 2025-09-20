import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/app_theme.dart';
import '../driver_sides_screens/home_screens/under_rieview_screen.dart';
import '../driver_sides_screens/login_scrrens/driver_detail_screen.dart';
import '../driver_sides_screens/home_screens/driver_dashboard_screen.dart';
import '../driver_sides_screens/verification_screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<_IntroSlide> slides = [
    _IntroSlide(
      title: "Book Rides & Deliveries",
      subtitle: "Travel anywhere or send packages\nwith ease",
      icon: Icons.directions_walk_rounded,
    ),
    _IntroSlide(
      title: "Drive and Earn",
      subtitle: "No commissions just connections\n and 100% is yours",
      icon: Icons.location_on,
    ),
    _IntroSlide(
      title: "Secure Payments",
      subtitle: "Fast and protected payment\nmethods built-in",
      icon: Icons.lock_outline,
    ),
    _IntroSlide(
      title: "24/7 Support",
      subtitle: "We're here to help you\nanytime, anywhere",
      icon: Icons.support_agent,
    ),
    _IntroSlide(
      title: "Eco-friendly Rides",
      subtitle: "Sustainability with every\njourney you take",
      icon: Icons.eco_outlined,
    ),
    _IntroSlide(
      title: "Earn with VezoH",
      subtitle: "Become a driver and start\nmaking money today",
      icon: Icons.attach_money,
    ),
    _IntroSlide(
      title: "Trusted by Thousands",
      subtitle: "Join the community that\nmoves smarter",
      icon: Icons.people_outline,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }
  Future<String?> _getVerificationStatus(String authToken) async {
    try {
      final url = Uri.parse("https://vizoh-app.onrender.com/api/driver/selected-services");
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $authToken",
      });

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        debugPrint("📦 Full API Response: $decoded");

        final verificationStatus =
            decoded['data']?['verificationStatus']?.toString() ?? "pending"; // 👈 fallback
        final serviceStatus =
            decoded['data']?['serviceStatus']?.toString() ?? "pending"; // 👈 fallback

        debugPrint("✅ Raw API verificationStatus: $verificationStatus");
        debugPrint("✅ Raw API serviceStatus: $serviceStatus");

        return "$verificationStatus|$serviceStatus";
      } else {
        debugPrint("❌ API Error: ${response.statusCode} → ${response.body}");
      }
    } catch (e) {
      debugPrint("❌ Exception fetching service status: $e");
    }
    return null;
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool("is_driver_logged_in") ?? false;
    final authToken = prefs.getString("auth_token");

    if (isLoggedIn && authToken != null) {
      final status = await _getVerificationStatus(authToken);

      if (status != null) {
        final parts = status.split("|");
        final verificationStatus = parts[0];
        final serviceStatus = parts[1];

        debugPrint("🔎 Verification Status: $verificationStatus");
        debugPrint("🔎 Service Status: $serviceStatus");

        if (verificationStatus == "pending" || serviceStatus == "pending") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const UnderReviewScreen()),
          );
        } else if (verificationStatus == "approved" && serviceStatus == "active") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const VerificationSubmittedScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          );
        }
      }
    }
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget buildSlide(_IntroSlide slide) {
    int index = slides.indexOf(slide);

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 800),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      'V',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.skyBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'vezoH',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your trusted transport and\ndelivery partner',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: AppColors.white),
                ),
                const SizedBox(height: 40),
                if (index > 0 && index != 2)
                  Container(
                    width: 250,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white30),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Icon(slide.icon, color: Colors.white, size: 48),
                        const SizedBox(height: 12),
                        Text(
                          slide.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          slide.subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(slides.length, (dotIndex) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentPage == dotIndex ? 12 : 10,
                      height: currentPage == dotIndex ? 12 : 10,
                      decoration: BoxDecoration(
                        color: currentPage == dotIndex
                            ? Colors.white
                            : AppColors.white.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handlePageChange(int index) {
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DriverDetailScreen()),
      );
    } else {
      setState(() => currentPage = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: slides.length,
          onPageChanged: handlePageChange,
          itemBuilder: (context, index) {
            if (index == 2) return const SizedBox.shrink();
            return buildSlide(slides[index]);
          },
        ),
      ),
    );
  }
}

class _IntroSlide {
  final String title;
  final String subtitle;
  final IconData icon;
  const _IntroSlide({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
