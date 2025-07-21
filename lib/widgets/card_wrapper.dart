import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CardWrapper extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const CardWrapper({super.key, required this.title, required this.subtitle, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.gray, width: 0.2),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Center(child: Icon(Icons.horizontal_rule_rounded, size: 30, color: AppColors.gray)),
          Center(child: Text(title, style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color:AppColors.black ))),
           SizedBox(height: 4),
          Center(child: Text(subtitle, style: const TextStyle(fontSize: 14, color: AppColors.gray))),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}
