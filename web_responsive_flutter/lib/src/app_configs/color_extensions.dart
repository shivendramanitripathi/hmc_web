import 'package:flutter/material.dart';

extension ColorExtension on Color {
  /// Convert Color to Hexadecimal String
  String toHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${(alpha.toRadixString(16).padLeft(2, '0'))}'
        '${(red.toRadixString(16).padLeft(2, '0'))}'
        '${(green.toRadixString(16).padLeft(2, '0'))}'
        '${(blue.toRadixString(16).padLeft(2, '0'))}';
  }

  /// Convert a Hexadecimal String to Color
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
