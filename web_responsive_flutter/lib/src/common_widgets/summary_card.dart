import 'package:flutter/material.dart';

import '../app_configs/app_colors.dart';
import '../app_configs/app_images.dart';

class SummaryCard extends StatelessWidget {
  final String imagePath;
  final String value;
  final String label;
  final Color backgroundColor;
  final double imageSize;
  final TextStyle? valueTextStyle;
  final TextStyle? labelTextStyle;
  final Color iconBackgroundColor;

  const SummaryCard({
    super.key,
    required this.imagePath,
    required this.value,
    required this.label,
    this.backgroundColor = Colors.white,
    this.imageSize = 20.0,
    this.valueTextStyle,
    this.labelTextStyle,
    required this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Image.asset(
                  AppImages.summaryVector,
                  height: 15,
                  width: 15,
                )),
              ),
              const SizedBox(height: 10),
              // Value
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darBlack,
                ),
              ),
              const SizedBox(height: 6),
              // Label
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
