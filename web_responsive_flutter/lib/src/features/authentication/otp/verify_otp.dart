import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../common_widgets/buttons/primary_button.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> with CodeAutoFill {
  String codeValue = "";

  @override
  void codeUpdated() {
    if (kDebugMode) {
      print("Update code $code");
    }
    setState(() {
      if (kDebugMode) {
        print("codeUpdated");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    listenOtp();
  }

  Future<bool> verifyOtp(String otp) async {
    await Future.delayed(const Duration(seconds: 2));
    return otp == "1234";
  }

  void _onVerifyPressed() async {
    // Capture the router instance before the async call
    final router = GoRouter.of(context);
    bool isVerified = await verifyOtp(codeValue);
    if (isVerified) {
      router.go('/dashboard');
    }
  }

  void listenOtp() async {
    // Avoid using context directly in async methods
    await SmsAutoFill().unregisterListener();
    listenForCode();
    SmsAutoFill().listenForCode;
    if (kDebugMode) {
      print("OTP listen Called");
    }
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    if (kDebugMode) {
      print("unregisterListener");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/otp');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: PinFieldAutoFill(
                currentCode: codeValue,
                codeLength: 4,
                onCodeChanged: (code) {
                  if (kDebugMode) {
                    print("onCodeChanged $code");
                  }
                  setState(() {
                    codeValue = code.toString();
                  });
                },
                onCodeSubmitted: (val) {
                  if (kDebugMode) {
                    print("onCodeSubmitted $val");
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(onPressed: _onVerifyPressed, text: 'Verify OTP'),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(onPressed: listenOtp, text: 'Resend'),
          ],
        ),
      ),
    );
  }
}
