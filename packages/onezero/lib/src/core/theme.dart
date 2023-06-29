import 'package:flutter/services.dart';
import '../../onezero.dart';

class ZeroTheme {
  const ZeroTheme({
    required this.colors,
    required this.typography,
  });

  final ColorTheme colors;
  final Typography typography;

  static ZeroTheme of(BuildContext context) {
    final ThemeScope? scope =
        context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(scope != null, 'No ThemeScope found in context');
    return scope!.theme;
  }

  static ThemeBrightness brightness(BuildContext context) {
    final ThemeScope? scope =
        context.dependOnInheritedWidgetOfExactType<ThemeScope>();
    assert(scope != null, 'No ThemeScope found in context');
    final brightness = MediaQuery.of(context).platformBrightness;
    switch (scope!.mode) {
      case ThemeMode.light:
        return ThemeBrightness.light;
      case ThemeMode.dark:
        return ThemeBrightness.dark;
      case ThemeMode.system:
        switch (brightness) {
          case Brightness.dark:
            return ThemeBrightness.dark;
          case Brightness.light:
            return ThemeBrightness.light;
        }
    }
  }
}

enum ThemeMode {
  light,
  dark,
  system,
}

enum ThemeBrightness {
  light,
  dark,
}

class ThemeScope extends InheritedWidget {
  const ThemeScope({
    required this.theme,
    required Widget child,
    Key? key,
    this.mode = ThemeMode.system,
  }) : super(key: key, child: child);

  final ZeroTheme theme;
  final ThemeMode mode;

  @override
  bool updateShouldNotify(ThemeScope oldWidget) {
    return theme != oldWidget.theme;
  }
}

final defaultTheme = ZeroTheme(
  colors: ColorTheme.fromRootColor(
    const Color.fromARGB(255, 255, 255, 255),
  ),
  typography: Typography.generate(),
);
