import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

Widget fromToFields({
  required TextEditingController fromController,
  required TextEditingController toController,
}) {
  return Column(
    children: [
      TextField(
        controller: fromController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.circle, size: 16, color: AppColors.skyBlue),
          hintText: 'From',
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      const SizedBox(height: 10),
      TextField(
        controller: toController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.circle, size: 16, color: AppColors.red),
          hintText: 'To',
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    ],
  );
}
