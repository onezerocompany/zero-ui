import 'package:flutter/painting.dart';

// apply brightness to a color
// 0 means reduce brightness by 100%
// 1 means no change
// 2 means increase brightness by 100%
// make sure it's a valid color
Color applyBrightnessToColor(Color color, double brightness) {
  if (brightness == 1) return color;

  // get the color components
  int r = color.red;
  int g = color.green;
  int b = color.blue;

  // apply the brightness
  r = (r * brightness).round();
  g = (g * brightness).round();
  b = (b * brightness).round();

  // make sure it's a valid color
  r = r.clamp(0, 255);
  g = g.clamp(0, 255);
  b = b.clamp(0, 255);

  // return the new color
  return Color.fromARGB(color.alpha, r, g, b);
}

extension BrightnessExtension on Color {
  Color withBrightness(double brightness) {
    return applyBrightnessToColor(this, brightness);
  }
}
