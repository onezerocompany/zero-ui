import 'package:zero_flutter/zero_flutter.dart';

class AdaptiveRangedValue<T> {
  final BreakPoint? minBreakpoint;
  final BreakPoint? maxBreakpoint;
  final T value;

  const AdaptiveRangedValue({
    this.minBreakpoint,
    this.maxBreakpoint,
    required this.value,
  });
}

class AdaptiveValue<T> {
  const AdaptiveValue({
    required this.fallbackValue,
    required this.values,
  });

  final T fallbackValue;
  final List<AdaptiveRangedValue<T>> values;

  T value(
    BreakPoint breakpoint,
  ) {
    int breakPointIndex = breakpoint.index;
    T determinedValue = fallbackValue;
    for (var value in values) {
      int minBreakPointIndex = value.minBreakpoint?.index ?? 0;
      int maxBreakPointIndex =
          value.maxBreakpoint?.index ?? BreakPoint.values.length;
      if (breakPointIndex >= minBreakPointIndex &&
          breakPointIndex <= maxBreakPointIndex) {
        determinedValue = value.value;
      }
    }
    return determinedValue;
  }
}
