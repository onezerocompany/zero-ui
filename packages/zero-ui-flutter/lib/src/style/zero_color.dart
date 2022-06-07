import 'dart:ui';

class ZeroColor {
  final Color color;
  final Color onColor;

  const ZeroColor({
    this.color = const Color(0xFF000000),
    this.onColor = const Color(0xFFFFFFFF),
  });
}
