import 'dart:ui' show FontFeature;
import 'package:flutter/widgets.dart' as flutter show TextStyle, FontWeight;
import 'package:onezero/onezero.dart';

/// Defines the style of a font.
class FontStyle {
  /// Creates a [FontStyle] object.
  ///
  /// The [family] parameter specifies the font family to use.
  /// The [weight] parameter specifies the font weight to use.
  /// The [size] parameter specifies the font size to use.
  /// The [letterSpacing] parameter specifies the space between letters.
  /// The [wordSpacing] parameter specifies the space between words.
  const FontStyle({
    this.family = 'Roboto',
    this.weight = 400,
    this.size = 14,
    this.iconSize = 22,
    this.letterSpacing = 0,
    this.wordSpacing = 0,
  });

  /// The font family to use.
  final String family;

  /// The font weight to use.
  final int weight;

  /// The font size to use.
  final double size;

  // Size of icons
  final double iconSize;

  /// The space between letters.
  final double letterSpacing;

  /// The space between words.
  final double wordSpacing;
}

/// Defines the style of a text.
class TypographyStyle {
  const TypographyStyle({
    this.font = const FontStyle(),
  });

  /// The font style to use.
  final FontStyle font;

  flutter.FontWeight fontWeight(int weight) {
    if (weight <= 0) {
      return flutter.FontWeight.w100;
    } else if (weight <= 149) {
      return flutter.FontWeight.w100;
    } else if (weight <= 249) {
      return flutter.FontWeight.w200;
    } else if (weight <= 349) {
      return flutter.FontWeight.w300;
    } else if (weight <= 449) {
      return flutter.FontWeight.w400;
    } else if (weight <= 549) {
      return flutter.FontWeight.w500;
    } else if (weight <= 649) {
      return flutter.FontWeight.w600;
    } else if (weight <= 749) {
      return flutter.FontWeight.w700;
    } else if (weight <= 849) {
      return flutter.FontWeight.w800;
    } else {
      return flutter.FontWeight.w900;
    }
  }

  flutter.TextStyle style(
    BuildContext context, {
    DynamicColor? color,
    ColorPriority priority = ColorPriority.primary,
  }) {
    return flutter.TextStyle(
      fontSize: font.size,
      fontWeight: fontWeight(font.weight),
      fontFamily: font.family,
      letterSpacing: font.letterSpacing,
      wordSpacing: font.wordSpacing,
      color: (color ?? DynamicColor()).resolve(
        context,
        priority: priority,
      ),
      fontFeatures: [
        FontFeature('wght', font.weight),
      ],
    );
  }
}

class TypographyCategory {
  const TypographyCategory({
    required this.pico,
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
    required this.huge,
    required this.jumbo,
  });

  final TypographyStyle pico;
  final TypographyStyle tiny;
  final TypographyStyle small;
  final TypographyStyle medium;
  final TypographyStyle large;
  final TypographyStyle huge;
  final TypographyStyle jumbo;

  static TypographyCategory fromSizes(
    String family, {
    double baseSize = 14.0,
    Curve sizeCurve = Curves.linear,
    double baseWeight = 500.0,
    Curve weightCurve = Curves.linear,
    double iconSizeMultiplier = 1.6,
    double baseLetterSpacing = 0.0,
    Curve letterSpacingCurve = Curves.linear,
    double baseWordSpacing = 0.0,
    Curve wordSpacingCurve = Curves.linear,
  }) {
    final size = baseSize * 2;
    final weight = baseWeight * 2;
    return TypographyCategory(
      pico: TypographyStyle(
        font: FontStyle(
          family: family,
          size: size * sizeCurve.transform(0.35),
          iconSize: size * sizeCurve.transform(0.35) * iconSizeMultiplier,
          weight: (weight * weightCurve.transform(0.47)).toInt(),
        ),
      ),
      tiny: TypographyStyle(
        font: FontStyle(
          family: family,
          size: size * sizeCurve.transform(0.4),
          iconSize: size * sizeCurve.transform(0.4) * iconSizeMultiplier,
          weight: (weight * weightCurve.transform(0.48)).toInt(),
        ),
      ),
      small: TypographyStyle(
        font: FontStyle(
          family: family,
          size: size * sizeCurve.transform(0.45),
          iconSize: size * sizeCurve.transform(0.45) * iconSizeMultiplier,
          weight: (weight * weightCurve.transform(0.49)).toInt(),
        ),
      ),
      medium: TypographyStyle(
        font: FontStyle(
          family: family,
          size: size * sizeCurve.transform(0.5),
          iconSize: size * sizeCurve.transform(0.5) * iconSizeMultiplier,
          weight: (weight * weightCurve.transform(0.5)).toInt(),
        ),
      ),
      large: TypographyStyle(
        font: FontStyle(
          family: family,
          size: size * sizeCurve.transform(0.55),
          iconSize: size * sizeCurve.transform(0.55) * iconSizeMultiplier,
          weight: (weight * weightCurve.transform(0.51)).toInt(),
        ),
      ),
      huge: TypographyStyle(
        font: FontStyle(
          family: family,
          size: size * sizeCurve.transform(0.6),
          iconSize: size * sizeCurve.transform(0.6) * iconSizeMultiplier,
          weight: (weight * weightCurve.transform(0.52)).toInt(),
        ),
      ),
      jumbo: TypographyStyle(
        font: FontStyle(
          family: family,
          size: size * sizeCurve.transform(0.65),
          iconSize: size * sizeCurve.transform(0.65) * iconSizeMultiplier,
          weight: (baseWeight * weightCurve.transform(0.53)).toInt(),
        ),
      ),
    );
  }
}

class Typography {
  Typography({
    required this.display,
    required this.headline,
    required this.title,
    required this.body,
    required this.caption,
    required this.button,
  });

  final TypographyCategory display;
  final TypographyCategory headline;
  final TypographyCategory title;
  final TypographyCategory body;
  final TypographyCategory caption;
  final TypographyCategory button;

  static Typography generate({
    String family = 'Roboto',
    double baseSize = 14.0,
  }) {
    return Typography(
      display: TypographyCategory.fromSizes(
        family,
        baseSize: baseSize * 1.5,
      ),
      headline: TypographyCategory.fromSizes(
        family,
        baseSize: baseSize * 1.3,
      ),
      title: TypographyCategory.fromSizes(
        family,
        baseSize: baseSize * 1.2,
      ),
      body: TypographyCategory.fromSizes(
        family,
        baseSize: baseSize,
      ),
      caption: TypographyCategory.fromSizes(
        family,
        baseSize: baseSize * 0.9,
      ),
      button: TypographyCategory.fromSizes(
        family,
        baseSize: baseSize * 1.05,
      ),
    );
  }
}
