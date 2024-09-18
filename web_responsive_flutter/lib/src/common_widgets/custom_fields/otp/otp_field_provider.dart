import 'package:flutter/material.dart';

class OtpInputFieldsProvider with ChangeNotifier {
  final int otpLength;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  OtpInputFieldsProvider({this.otpLength = 6}) {
    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
    for (var controller in controllers) {
      controller.addListener(() {
        notifyListeners();
      });
    }
  }

  String get otp => controllers.map((controller) => controller.text).join();

  void clear() {
    for (var controller in controllers) {
      controller.clear();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
