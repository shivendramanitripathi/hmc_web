import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';

import '../../../common_widgets/buttons/primary_button.dart';

class SendOTPScreen extends StatelessWidget {
  SendOTPScreen({super.key});

  final TextEditingController mobileNumber = TextEditingController();

  Future<void> submit(BuildContext context) async {
    if (mobileNumber.text.isEmpty) return;

    // Save the route operation before the async operation
    final router = GoRouter.of(context);

    String? appSignatureID;
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        appSignatureID = await SmsAutoFill().getAppSignature;
      } catch (e) {
        if (kDebugMode) {
          print('Failed to get app signature: $e');
        }
        appSignatureID = null;
      }
    }

    final Map<String, String> sendOtpData = {
      "mobile_number": mobileNumber.text,
      "app_signature_id": appSignatureID ?? '',
    };

    if (kDebugMode) {
      print(sendOtpData);
    }

    // Perform the navigation after the async operation, using the saved `router`
    router.go('/verifyByOtp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/login');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.color2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: mobileNumber,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Mobile Number",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            PrimaryButton(onPressed: () => submit(context), text: 'Submit'),
          ],
        ),
      ),
    );
  }
}
