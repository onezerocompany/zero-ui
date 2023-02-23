import 'package:zero_flutter/zero_flutter.dart';

class StyleConfig {
  const StyleConfig({
    this.gutters = const AdaptiveValue<double>(
      defaultValue: 12,
      values: [
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.sm,
          value: 16,
        ),
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.md,
          value: 28,
        ),
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.xl,
          value: 36,
        ),
      ],
    ),
    this.contentPadding = const AdaptiveValue<double>(
      defaultValue: 22,
      values: [
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.sm,
          value: 36,
        ),
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.md,
          value: 44,
        ),
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.xl,
          value: 56,
        ),
      ],
    ),
    this.primaryColor = Colors.blue,
    this.primaryTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    this.background,
    this.labelTextStyle,
    this.titleTextStyle,
  });

  // spacing and sizing
  final AdaptiveValue<double> gutters;
  final AdaptiveValue<double> contentPadding;

  // colors
  final Color primaryColor;

  // background builder that provides build context
  final Widget Function(BuildContext)? background;

  // text styles
  final TextStyle primaryTextStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? titleTextStyle;
}
