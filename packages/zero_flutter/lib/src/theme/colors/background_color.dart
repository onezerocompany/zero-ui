import 'package:flutter/painting.dart';

const white = Color(0xFFFFFFFF);

Color backgroundColor({
  Color foregroundColor = const Color(0xFF000000),
}) {
  double luminance = foregroundColor.computeLuminance();
  if (luminance < 0.05) {
    return const Color.fromARGB(255, 201, 201, 221);
  } else if (luminance < 0.6) {
    // return withOpacity((luminance - 0.2).clamp(0.25, 0.9));
    return Color.alphaBlend(
      foregroundColor.withOpacity((luminance - 0.2).clamp(0.25, 0.9)),
      white,
    );
  } else {
    return Color.alphaBlend(
      const Color.fromARGB(255, 33, 29, 41)
          .withOpacity(luminance.clamp(0.1, 0.8)),
      white,
    );
  }
}

extension BackgroundColorExtension on Color {
  Color get background => backgroundColor(foregroundColor: this);
}
