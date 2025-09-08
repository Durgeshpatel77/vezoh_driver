import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.skyBlue,
        foregroundColor: AppColors.white,
        elevation: 0,
        title: const Text("Earnings"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _earningsCard(),
            const SizedBox(height: 12),
            _thisWeekCard(),
            const SizedBox(height: 12),
            _withdrawCard(),
            const SizedBox(height: 12),
            _recentEarningsCard(),
          ],
        ),
      ),
    );
  }

  Widget _earningsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          const Text(
            "₹1395",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.skyBlue),
          ),
          const Text("Today's earnings"),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _iconStat("8", "Trips"),
              _iconStat("6.5h", "Online"),
              _iconStat("₹156", "Average"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _thisWeekCard() {
    return _sectionCard(
      title: "This week",
      children: [
        _itemRow("Total trips", "42", valueColor: AppColors.gray),
        _itemRow("Online hours", "38.5 hrs", valueColor: AppColors.gray),
        _itemRow("Total earnings", "₹8,450", valueColor: AppColors.skyBlue),
      ],
    );
  }

  Widget _withdrawCard() {
    return _sectionCard(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Text("Available to withdraw",style: TextStyle(color: AppColors.black,fontSize: 16),),
              Spacer(),
              Text(
                "₹7,250",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text("Withdraw earnings", style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 6),
        Center(
          child: Text(
            "Instant transfer to your bank account",
            style: TextStyle(fontSize: 12, color: AppColors.gray),
          ),
        ),
      ],
    );
  }

  Widget _recentEarningsCard() {
    return _sectionCard(
      title: "Recent earnings",
      children: [
        _recentEarning("Koramangala -> MG Road", "Today, 2:45 PM", "+₹136", isPositive: true),
        const Divider(height: 20),
        _recentEarning("HSR Layout -> Indiranagar", "Today, 1:20 PM", "+₹156", isPositive: true),
        const Divider(height: 20),
        _recentEarning("Withdrawal to bank", "Yesterday, 6:30 PM", "-₹5,000", isPositive: false),
      ],
    );
  }

  Widget _sectionCard({String? title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title.isNotEmpty) ...[
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 20), // 👈 Added here
          ],
          ...children,
        ],
      ),
    );
  }

  Widget _iconStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.gray,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _itemRow(String title, String value, {Color valueColor = AppColors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: valueColor)),
        ],
      ),
    );
  }

  Widget _recentEarning(String title, String time, String amount, {required bool isPositive}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text(time, style: const TextStyle(fontSize: 12, color: AppColors.gray)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray, width: 0.4),
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent,
          ),
          child: Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isPositive ? Colors.green : AppColors.skyBlue,
            ),
          ),
        ),
      ],
    );
  }
}
