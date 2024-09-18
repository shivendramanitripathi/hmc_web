import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_fields/otp/otp_field_provider.dart';

class OtpInputFields extends StatelessWidget {
  final int otpLength;
  final ValueChanged<String> onOtpChanged;

  const OtpInputFields({
    super.key,
    this.otpLength = 6,
    required this.onOtpChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OtpInputFieldsProvider(otpLength: otpLength),
      child: Consumer<OtpInputFieldsProvider>(
        builder: (context, provider, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(otpLength, (index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 8,
                child: TextField(
                  controller: provider.controllers[index],
                  focusNode: provider.focusNodes[index],
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: AppColors.highlightBorderColor),
                    ),
                    counterText: '',
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (index < otpLength - 1) {
                        provider.focusNodes[index + 1].requestFocus();
                      } else {
                        provider.focusNodes[index].unfocus();
                      }
                    } else if (value.isEmpty && index > 0) {
                      provider.focusNodes[index - 1].requestFocus();
                    }
                    onOtpChanged(provider.otp);
                  },
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
