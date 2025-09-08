import 'dart:async';
import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import 'driveto_pickup_courier_screen.dart';
import 'driveto_pickupride_screen.dart';

class IncomingRequestsPage extends StatefulWidget {
  const IncomingRequestsPage({super.key});

  @override
  State<IncomingRequestsPage> createState() => _IncomingRequestsPageState();
}

class _IncomingRequestsPageState extends State<IncomingRequestsPage> {
  double _progress = 1.0;
  int _remainingSeconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          _progress = _remainingSeconds / 30;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requests = [
      {
        'name': 'Hyundai Accent Gaurav',
        'tag': 'RIDE',
        'price': '₹160',
        'pickup': 'Koramangala 5th Block',
        'drop': 'MG Road Metro',
        'time': '3 min',
        'distance': '300 m',
        'avatar': 'HA',
        'rating': '5.6 (654)',
        'borderColor': AppColors.skyBlue,
      },
      {
        'name': 'Maruti Suzuki Wagon R Geeta',
        'tag': 'COURIER',
        'price': '₹85',
        'pickup': 'HSR Layout',
        'drop': 'Indiranagar',
        'time': '4 min',
        'distance': '400 m',
        'avatar': 'MS',
        'rating': '4.9 (984)',
        'borderColor': AppColors.orange,
        'packageDetails': 'Small package - Electronics',
      },
      {
        'name': 'Hyundai Eon Raghu',
        'tag': 'RIDE',
        'price': '₹180',
        'pickup': 'Whitefield',
        'drop': 'Electronic City',
        'time': '5 min',
        'distance': '350 m',
        'avatar': 'HE',
        'rating': '4.8 (512)',
        'borderColor': AppColors.skyBlue,
      },
      {
        'name': 'Tata Courier Express',
        'tag': 'COURIER',
        'price': '₹100',
        'pickup': 'JP Nagar',
        'drop': 'Jayanagar',
        'time': '2 min',
        'distance': '200 m',
        'avatar': 'TC',
        'rating': '4.7 (600)',
        'borderColor': AppColors.orange,
        'packageDetails': 'Documents - Urgent',
      },
      {
        'name': 'Courier King Balaji',
        'tag': 'COURIER',
        'price': '₹120',
        'pickup': 'Malleshwaram',
        'drop': 'Hebbal',
        'time': '6 min',
        'distance': '700 m',
        'avatar': 'CK',
        'rating': '5.0 (1044)',
        'borderColor': AppColors.orange,
        'packageDetails': 'Food Delivery',
      },
      {
        'name': 'Honda City Neha',
        'tag': 'RIDE',
        'price': '₹190',
        'pickup': 'BTM Layout',
        'drop': 'Bellandur',
        'time': '4 min',
        'distance': '500 m',
        'avatar': 'HN',
        'rating': '4.9 (888)',
        'borderColor': AppColors.skyBlue,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Incoming Requests', style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.skyBlue,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppColors.white)),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'You have multiple requests',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const Center(
            child: Text(
              'Choose which request to accept',
              style: TextStyle(fontSize: 13, color: AppColors.gray),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: requests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final r = requests[index];
                return _buildRequestCard(
                  context,
                  name: r['name'] as String,
                  tag: r['tag'] as String,
                  price: r['price'] as String,
                  pickup: r['pickup'] as String,
                  drop: r['drop'] as String,
                  time: r['time'] as String,
                  distance: r['distance'] as String,
                  avatar: r['avatar'] as String,
                  rating: r['rating'] as String,
                  borderColor: r['borderColor'] as Color,
                  packageDetails: r['packageDetails'] as String?,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _progress,
                    minHeight: 8,
                    color: AppColors.black,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Requests auto-expire in $_remainingSeconds seconds',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.gray.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(
      BuildContext context, {
        required String name,
        required String tag,
        required String price,
        required String pickup,
        required String drop,
        required String time,
        required String distance,
        required String avatar,
        required String rating,
        required Color borderColor,
        String? packageDetails,
      }) {
    final tagColor = tag.toUpperCase() == 'RIDE' ? AppColors.skyBlue : AppColors.orange;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: borderColor,
                radius: 20,
                child: Text(avatar, style: const TextStyle(color: AppColors.black)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildTag(tag, tagColor),
                        Text("★ $rating", style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(price, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: tagColor)),
                  const SizedBox(height: 4),
                  Text(time, style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                  Text(distance, style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.circle, size: 6, color: AppColors.skyBlue),
              const SizedBox(width: 6),
              Expanded(child: Text(pickup)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.circle, size: 6, color: AppColors.red),
              const SizedBox(width: 6),
              Expanded(child: Text(drop)),
            ],
          ),
          if (packageDetails != null) ...[
            const SizedBox(height: 6),
            Text(packageDetails, style: const TextStyle(fontSize: 12, color: AppColors.gray)),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    side: const BorderSide(color: AppColors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Decline', style: TextStyle(color: AppColors.red)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (tag.toUpperCase() == 'RIDE') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DrivetoPickuprideScreen(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DrivetoPickupCourierScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tagColor,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Accept', style: TextStyle(color: AppColors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color.withOpacity(0.2),
      ),
      child: Text(
        tag,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
