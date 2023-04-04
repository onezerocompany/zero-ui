import 'package:zero_ui/zero_ui.dart';

part 'adaptive_context.g.dart';

// screen size riverpod provider
@Riverpod(keepAlive: true)
class ScreenSize extends _$ScreenSize {
  @override
  Size build() {
    return Size.zero;
  }

  void set(Size value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
BreakPoint breakPoint(BreakPointRef ref) {
  final size = ref.watch(screenSizeProvider);
  final style = ref.watch(styleConfigProvider);
  return style.breakpoints.breakpoint(size.width);
}

@riverpod
int panels(PanelsRef ref) {
  final breakpoint = ref.watch(breakPointProvider);
  return const AdaptiveValue<int>(
    fallbackValue: 1,
    values: [
      AdaptiveRangedValue(
        minBreakpoint: BreakPoint.md,
        value: 2,
      ),
      AdaptiveRangedValue(
        minBreakpoint: BreakPoint.lg,
        value: 3,
      ),
    ],
  ).value(breakpoint);
}
