import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/utils/string_hardcoded_ext.dart';

class VerificationMessage extends StatelessWidget {
  final String contactInfo;
  final bool usePhoneNumber;
  final String prefixText;
  final Color maskedPhoneColor;

  const VerificationMessage({
    super.key,
    required this.contactInfo,
    required this.usePhoneNumber,
    required this.prefixText,
    this.maskedPhoneColor = AppColors.maskedPhoneColor,
  });

  @override
  Widget build(BuildContext context) {
    String maskedContactInfo =
        usePhoneNumber ? maskPhoneNumber(contactInfo) : maskEmail(contactInfo);

    return RichText(
      text: TextSpan(
        text: '$prefixText '.hardcoded,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.primaryTextColor,
        ),
        children: [
          TextSpan(
            text: maskedContactInfo,
            style: TextStyle(
              fontSize: 16,
              color: maskedPhoneColor,
            ),
          ),
        ],
      ),
    );
  }

  String maskPhoneNumber(String contactInfo) {
    final parts = contactInfo.split('-');
    if (parts.length == 2) {
      final countryCode = parts[0];
      final phoneNumber = parts[1];
      if (phoneNumber.length > 2) {
        final maskedPhone = '${phoneNumber.substring(0, 2)}******';
        return '($countryCode) $maskedPhone';
      }
      return phoneNumber;
    }
    return contactInfo;
  }

  String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length == 2) {
      final localPart = parts[0];
      final domainPart = parts[1];
      final maskedLocalPart = localPart.length > 2
          ? '${localPart.substring(0, 2)}******'
          : localPart;
      return '$maskedLocalPart@$domainPart';
    }
    return email;
  }
}
