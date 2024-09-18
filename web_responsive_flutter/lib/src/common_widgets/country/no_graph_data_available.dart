import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/constants/app_sizes.dart';

class NoGraphDataAvailable extends StatelessWidget {
  const NoGraphDataAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.p32),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width / 2.5),
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            'Graph is unavailable',
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
