import 'package:flutter/widgets.dart';
import 'package:zero_ui/zero_ui.dart';

class ZeroThemeColors {
  final ZeroColor primary;
  final ZeroColor surface;

  const ZeroThemeColors({
    this.primary = const ZeroColor(),
    this.surface =
        const ZeroColor(color: Color(0xFFFFFFFF), onColor: Color(0xFF000000)),
  });
}

class ZeroThemeTypography {
  // TODO: add default style for header, footer and such
  const ZeroThemeTypography();
}

class ZeroTheme {
  final ZeroThemeColors colors;
  final ZeroThemeTypography typography;

  const ZeroTheme({
    Key? key,
    this.colors = const ZeroThemeColors(),
    this.typography = const ZeroThemeTypography(),
  });
}
