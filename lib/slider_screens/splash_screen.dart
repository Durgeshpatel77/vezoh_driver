import 'package:flutter/material.dart';

import '../driver_sides_screens/login_scrrens/driver_detail_screen.dart';
import '../theme/app_theme.dart';

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
    // Index 2 will be skipped
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget buildSlide(_IntroSlide slide) {
    int index = slides.indexOf(slide);

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 800, // optional minimum height
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Logo Box
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

                /// App Name
                Text(
                  'vezoH',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),

                const SizedBox(height: 10),

                /// Subtitle
                Text(
                  'Your trusted transport and\ndelivery partner',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                  ),
                ),

                const SizedBox(height: 40),

                /// Show card only from index 1 (skip 0 and 2)
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
                        Icon(
                          slide.icon,
                          color: Colors.white,
                          size: 48,
                        ),
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

                /// Dot Indicators
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
      // Navigate to GetStartedScreen instead of showing index 2
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
            if (index == 2) {
              // Don’t show slide at index 2, but trigger redirect
              return const SizedBox.shrink();
            }
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
