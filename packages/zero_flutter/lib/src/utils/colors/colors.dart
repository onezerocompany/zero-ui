import 'package:flutter/material.dart' as material;
import 'package:zero_flutter/zero_flutter.dart';

export 'background_color.dart';
export 'foreground_color.dart';
export 'brightness.dart';
export 'hex_colors.dart';

class Colors {
  // primary colors
  final Color primary;

  // basic colors
  static const Color transparent = material.Colors.transparent;
  static const Color black = material.Colors.black;
  static const Color white = material.Colors.white;
  static const Color offWhite = material.Color.fromARGB(255, 243, 241, 241);
  static const Color offBlack = Color(0xFF13131E);
  static const Color red = material.Colors.red;
  static const Color green = material.Colors.green;
  static const Color blue = material.Colors.blue;
  static const Color yellow = material.Colors.yellow;
  static const Color orange = material.Colors.orange;
  static const Color purple = material.Colors.purple;
  static const Color pink = material.Colors.pink;
  static const Color brown = material.Colors.brown;
  static const Color grey = material.Colors.grey;
  static const Color teal = material.Colors.teal;

  // state colors
  static const Color success = material.Color.fromARGB(255, 38, 197, 126);
  static const Color successful = success;
  static const Color warning = Color(0xFFFFAB00);
  static const Color warn = warning;
  static const Color error = material.Color.fromARGB(255, 242, 14, 86);
  static const Color destructive = error;

  get lightScheme {
    ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    );
    return scheme.copyWith(
      primary: primary,
      surface: scheme.surface.withBrightness(0.96),
    );
  }

  get darkScheme {
    ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
    );
    return scheme.copyWith(
      primary: primary,
      surface: scheme.surface.withBrightness(0.6),
    );
  }

  const Colors({
    this.primary = material.Colors.black,
  });
}
