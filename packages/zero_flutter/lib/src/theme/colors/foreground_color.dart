import 'package:flutter/painting.dart';

const List<Color> colors = [
  Color(0xFF000000),
  Color.fromARGB(255, 116, 114, 125),
  Color(0xFFFFFFFF),
];

Color foregroundColor({required Color backgroundColor}) {
  // find the color with the highest contrast
  Color? bestColor;
  double? bestContrast;
  for (Color color in colors) {
    double contrast =
        color.computeLuminance() - backgroundColor.computeLuminance();
    if (bestContrast == null || contrast.abs() > bestContrast.abs()) {
      bestContrast = contrast;
      bestColor = color;
    }
  }
  return bestColor ?? const Color(0xFF000000);
}

extension ForegroundColorExtension on Color {
  Color get foreground => foregroundColor(backgroundColor: this);
}
