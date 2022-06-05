import 'package:zero_ui/zero_ui.dart';

class ZeroThemeColors {
  final ZeroColor primary;
  final ZeroColor surface;

  const ZeroThemeColors({
    required this.primary,
    required this.surface,
  });
}

class ZeroThemeTypography {
  const ZeroThemeTypography();
}

class ZeroTheme {
  final ZeroThemeColors colors;
  final ZeroThemeTypography typography;

  const ZeroTheme({
    required this.colors,
    required this.typography,
  });
}
