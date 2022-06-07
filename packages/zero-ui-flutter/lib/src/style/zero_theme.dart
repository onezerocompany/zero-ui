import 'dart:html';

import 'package:flutter/widgets.dart';
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

class ZeroTheme extends StatelessWidget {
  final ZeroThemeColors colors;
  final ZeroThemeTypography typography;

  const ZeroTheme({
    Key? key,
    required this.colors,
    required this.typography,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ZeroTheme(context, colors, typography);
  }
}

class _ZeroTheme extends InheritedTheme {
  const _ZeroTheme({Key? key, required this.zeroTheme, required Widget child})
      : super(key: key, child: child);

  final ZeroTheme? zeroTheme;

  @override
  bool updateShouldNotify(covariant _ZeroTheme oldWidget) =>
      oldWidget.zeroTheme == zeroTheme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return _ZeroTheme(zeroTheme: zeroTheme, child: child);
  }
}
