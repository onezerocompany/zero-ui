import 'package:flutter/material.dart';

TextTheme textTheme({
  required TextStyle primaryTextStyle,
  TextStyle? titleTextStyle,
  TextStyle? labelTextStyle,
}) {
  final title = titleTextStyle ?? primaryTextStyle;
  final label = labelTextStyle ?? primaryTextStyle;

  return TextTheme(
    // regular, 57px, 64px line height, 0 letter spacing
    displayLarge: title.copyWith(
      fontSize: 57,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      // line height of 64 / 57 = 1.12
      height: 1.12,
    ),
    // regular, 45px, 52px line height, 0 letter spacing
    displayMedium: title.copyWith(
      fontSize: 45,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      // line height of 52 / 45 = 1.15
      height: 1.15,
    ),
    // regular, 36px, 44px line height, 0 letter spacing
    displaySmall: title.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      // line height of 44 / 36 = 1.22
      height: 1.22,
    ),

    // regular, 32px, 40px line height, 0 letter spacing
    headlineLarge: title.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
      // line height of 40 / 32 = 1.25
      height: 1.25,
    ),
    // regular, 28px, 36px line height, 0 letter spacing
    headlineMedium: title.copyWith(
      fontSize: 28,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
      // line height of 36 / 28 = 1.28
      height: 1.28,
    ),
    // regular, 24px, 32px line height, 0 letter spacing
    headlineSmall: title.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      letterSpacing: 0,
      // line height of 32 / 24 = 1.33
      height: 1.33,
    ),

    // medium, 22px, 28px line height, 0 letter spacing
    titleLarge: title.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      // line height of 28 / 22 = 1.27
      height: 1.27,
    ),
    // medium, 16px, 24px line height, 0.15 letter spacing
    titleMedium: title.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      // line height of 24 / 16 = 1.5
      height: 1.5,
    ),
    // medium, 14px, 20px line height, 0.1 letter spacing
    titleSmall: title.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      // line height of 20 / 14 = 1.43
      height: 1.43,
    ),

    // medium, 14px, 20px line height, 0.1 letter spacing
    labelLarge: label.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      // line height of 20 / 14 = 1.43
      height: 1.43,
    ),
    // medium, 12px, 16px line height, 0.5 letter spacing
    labelMedium: label.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      // line height of 16 / 12 = 1.33
      height: 1.33,
    ),
    // medium, 11px, 16px line height, 0.5 letter spacing
    labelSmall: label.copyWith(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      // line height of 16 / 11 = 1.45
      height: 1.45,
    ),

    // regular 16px, 24px line height, 0.15 letter spacing
    bodyLarge: primaryTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.15,
      // line height of 24 / 16 = 1.5
      height: 1.5,
    ),
    // regular 14px, 20px line height, 0.25 letter spacing
    bodyMedium: primaryTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.25,
      // line height of 20 / 14 = 1.43
      height: 1.43,
    ),
    // regular 12px, 16px line height, 0.4 letter spacing
    bodySmall: primaryTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      letterSpacing: 0.4,
      // line height of 16 / 12 = 1.33
      height: 1.33,
    ),
  );
}
