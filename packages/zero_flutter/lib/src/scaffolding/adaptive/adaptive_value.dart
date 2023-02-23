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
  final T defaultValue;
  final List<AdaptiveRangedValue<T>> values;
  const AdaptiveValue({
    required this.defaultValue,
    required this.values,
  });

  static fixed<T>(T value) {
    return AdaptiveValue<T>(
      defaultValue: value,
      values: [],
    );
  }

  T value(BreakPoint breakpoint) {
    int breakPointIndex = breakpoint.index;
    T determinedValue = defaultValue;
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
