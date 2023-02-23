import 'package:flutter/painting.dart';

Color colorFromhex({required String hex}) {
  // convert 3 digit hex to 6 digit hex
  if (hex.length == 3) {
    hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
  }
  // strip alpha channel
  if (hex.length == 8) {
    hex = hex.substring(2);
  }
  // in case the hex is not 6 digits return black
  if (hex.length != 6) {
    return const Color(0xFF000000);
  }
  return Color(int.parse('0xFF$hex'));
}

extension HexString on String {
  Color toColor() {
    return colorFromhex(hex: this);
  }
}

extension HexColor on Color {
  String toHex() {
    return '#${value.toRadixString(16).substring(2).padLeft(6, '0')}';
  }
}
