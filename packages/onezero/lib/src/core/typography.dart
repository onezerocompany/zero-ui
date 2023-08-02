import 'dart:ui' show FontFeature;
import 'package:flutter/widgets.dart' as flutter show TextStyle, FontWeight;
import 'package:meta/meta.dart';
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

  FontStyle copyWith({
    String? family,
    int? weight,
    double? size,
    double? iconSize,
    double? letterSpacing,
    double? wordSpacing,
  }) {
    return FontStyle(
      family: family ?? this.family,
      weight: weight ?? this.weight,
      size: size ?? this.size,
      iconSize: iconSize ?? this.iconSize,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
    );
  }
}

/// Defines the style of a text.
class TypographyStyle {
  const TypographyStyle({
    this.font = const FontStyle(),
  });

  /// The font style to use.
  final FontStyle font;

  @internal
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

  TypographyStyle copyWith({
    String? family,
    int? weight,
    double? size,
    double? iconSize,
    double? letterSpacing,
    double? wordSpacing,
  }) {
    return TypographyStyle(
      font: font.copyWith(
        family: family,
        weight: weight,
        size: size,
        iconSize: iconSize,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
      ),
    );
  }
}

enum TypographySize {
  tiny,
  small,
  medium,
  large,
  huge,
}

class TypographyCategory {
  const TypographyCategory({
    required this.sizes,
  }) : assert(sizes.length == TypographySize.values.length);

  final Map<TypographySize, TypographyStyle> sizes;

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
      sizes: {
        TypographySize.tiny: TypographyStyle(
          font: FontStyle(
            family: family,
            size: size * sizeCurve.transform(0.4),
            iconSize: size * sizeCurve.transform(0.4) * iconSizeMultiplier,
            weight: (weight * weightCurve.transform(0.48)).toInt(),
          ),
        ),
        TypographySize.small: TypographyStyle(
          font: FontStyle(
            family: family,
            size: size * sizeCurve.transform(0.45),
            iconSize: size * sizeCurve.transform(0.45) * iconSizeMultiplier,
            weight: (weight * weightCurve.transform(0.49)).toInt(),
          ),
        ),
        TypographySize.medium: TypographyStyle(
          font: FontStyle(
            family: family,
            size: size * sizeCurve.transform(0.5),
            iconSize: size * sizeCurve.transform(0.5) * iconSizeMultiplier,
            weight: (weight * weightCurve.transform(0.5)).toInt(),
          ),
        ),
        TypographySize.large: TypographyStyle(
          font: FontStyle(
            family: family,
            size: size * sizeCurve.transform(0.55),
            iconSize: size * sizeCurve.transform(0.55) * iconSizeMultiplier,
            weight: (weight * weightCurve.transform(0.51)).toInt(),
          ),
        ),
        TypographySize.huge: TypographyStyle(
          font: FontStyle(
            family: family,
            size: size * sizeCurve.transform(0.6),
            iconSize: size * sizeCurve.transform(0.6) * iconSizeMultiplier,
            weight: (weight * weightCurve.transform(0.52)).toInt(),
          ),
        ),
      },
    );
  }

  TypographyStyle styleForSize(TypographySize size) {
    return sizes[size]!;
  }

  TypographyStyle get tiny => styleForSize(TypographySize.tiny);
  TypographyStyle get small => styleForSize(TypographySize.small);
  TypographyStyle get medium => styleForSize(TypographySize.medium);
  TypographyStyle get large => styleForSize(TypographySize.large);
  TypographyStyle get huge => styleForSize(TypographySize.huge);
}

enum TypographyCategoryType {
  display,
  headline,
  title,
  body,
  caption,
  button,
}

class Typography {
  Typography({
    required this.categories,
  }) : assert(categories.length == TypographyCategoryType.values.length);

  final Map<TypographyCategoryType, TypographyCategory> categories;

  static Typography generate({
    String family = 'Roboto',
    double baseSize = 14.0,
  }) {
    return Typography(
      categories: {
        TypographyCategoryType.display: TypographyCategory.fromSizes(
          family,
          baseSize: baseSize * 2.5,
        ),
        TypographyCategoryType.headline: TypographyCategory.fromSizes(
          family,
          baseSize: baseSize * 2,
        ),
        TypographyCategoryType.title: TypographyCategory.fromSizes(
          family,
          baseSize: baseSize * 1.5,
        ),
        TypographyCategoryType.body: TypographyCategory.fromSizes(
          family,
          baseSize: baseSize,
        ),
        TypographyCategoryType.caption: TypographyCategory.fromSizes(
          family,
          baseSize: baseSize * 0.9,
        ),
        TypographyCategoryType.button: TypographyCategory.fromSizes(
          family,
          baseSize: baseSize * 1.05,
        ),
      },
    );
  }

  TypographyCategory categoryForType(TypographyCategoryType type) {
    return categories[type]!;
  }

  TypographyCategory get display =>
      categoryForType(TypographyCategoryType.display);
  TypographyCategory get headline =>
      categoryForType(TypographyCategoryType.headline);
  TypographyCategory get title => categoryForType(TypographyCategoryType.title);
  TypographyCategory get body => categoryForType(TypographyCategoryType.body);
  TypographyCategory get caption =>
      categoryForType(TypographyCategoryType.caption);
  TypographyCategory get button =>
      categoryForType(TypographyCategoryType.button);
}
