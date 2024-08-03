import 'package:flutter/material.dart';

class AppColors {
  // black and white
  static Color neutralColor700 = HexColor.fromHex('1C1C1C');
  static Color neutralColor200 = HexColor.fromHex('1C1C1C');

  static Color primary = const Color(0xff7FFA88);
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceAll('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
