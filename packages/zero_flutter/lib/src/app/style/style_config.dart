import 'package:zero_flutter/zero_flutter.dart';

part 'style_config.g.dart';

class StyleConfig {
  const StyleConfig({
    this.gutters = const AdaptiveValue<double>(
      fallbackValue: 12,
      values: [
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.sm,
          value: 12,
        ),
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.md,
          value: 14,
        ),
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.xl,
          value: 16,
        ),
      ],
    ),
    this.contentPadding = const AdaptiveValue<EdgeInsets>(
      fallbackValue: EdgeInsets.all(22),
      values: [
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.sm,
          value: EdgeInsets.all(36),
        ),
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.md,
          value: EdgeInsets.all(44),
        ),
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.xl,
          value: EdgeInsets.all(56),
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
    this.breakpoints = const BreakPoints(),
  });

  // spacing and sizing
  final AdaptiveValue<double> gutters;
  final AdaptiveValue<EdgeInsets> contentPadding;

  // colors
  final Color primaryColor;

  // background builder that provides build context
  final Widget Function(BuildContext)? background;

  // text styles
  final TextStyle primaryTextStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? titleTextStyle;

  // Adaptive breakpoints
  final BreakPoints breakpoints;
}

@Riverpod(keepAlive: true)
StyleConfig styleConfig(StyleConfigRef ref) {
  final config = ref.watch(appConfigProvider);
  return config.style;
}
