import 'dart:math';

import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';

final omnibarFocus = FocusNode();

class OmniContainer extends ConsumerWidget {
  OmniContainer({
    super.key,
    this.cornerRadius = const AdaptiveValue<BorderRadius>(
      fallbackValue: BorderRadius.all(Radius.circular(18)),
      values: [
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.sm,
          value: BorderRadius.all(Radius.circular(20)),
        ),
      ],
    ),
    this.openCornerRadius = const AdaptiveValue<BorderRadius>(
      fallbackValue: BorderRadius.all(Radius.circular(22)),
      values: [
        AdaptiveRangedValue(
          minBreakpoint: BreakPoint.sm,
          value: BorderRadius.all(Radius.circular(26)),
        ),
      ],
    ),
  });

  final AdaptiveValue<BorderRadius> cornerRadius;
  final AdaptiveValue<BorderRadius> openCornerRadius;

  final searchController = TextEditingController();

  static EdgeInsets position(
    BuildContext context,
    WidgetRef ref, {
    required Size size,
    required double openAmount,
    required double twoPanelAmount,
    required double keyboardHeight,
    required double barHeight,
  }) {
    final style = ref.watch(styleConfigProvider);
    final breakpoint = ref.watch(breakPointProvider);
    final safeInsets = MediaQuery.of(context).padding;
    final gutter = style.gutters.value(breakpoint);

    final maxBarSize = Size(
      size.width - safeInsets.left - safeInsets.right - (gutter * 2),
      size.height - safeInsets.top - safeInsets.bottom - (gutter * 2),
    );

    final verticalOverage = (maxBarSize.height - 600).clamp(0, double.infinity);
    final horizontalOverage =
        (maxBarSize.width - 480).clamp(0, double.infinity);
    final multiOpen = EdgeInsets.only(
      top: max(
        safeInsets.top + gutter,
        gutter + verticalOverage / 2,
      ),
      bottom: max(
        safeInsets.bottom + gutter,
        gutter + verticalOverage / 2 - keyboardHeight,
      ),
      left: max(
        safeInsets.left + gutter,
        gutter + horizontalOverage / 2,
      ),
      right: max(
        safeInsets.right + gutter,
        gutter + horizontalOverage / 2,
      ),
    );

    final scaffoldWidth = min(size.width, 1280);
    final double leftWidth = (scaffoldWidth * 0.4).clamp(330, 500);
    final leftDistance =
        max(((size.width - scaffoldWidth) / 2) + gutter, gutter);
    final singlePanelState = EdgeInsets.only(
      top: size.height - barHeight,
      left: 0,
      right: 0,
      bottom: 0,
    );

    // final multiBottom = max(safeInsets.bottom + gutter, gutter);
    final multiBottom = PageContent.padding(
      context,
      ref,
      extend: false,
      fadeEdges: true,
      layout: PageLayout.fullscreen,
      offsetBar: false,
    ).bottom;
    final multiPanelState = EdgeInsets.only(
      top: size.height - multiBottom - barHeight,
      left: max(safeInsets.left, leftDistance),
      right: size.width -
          leftWidth -
          safeInsets.right -
          leftDistance +
          (gutter * 2),
      bottom: multiBottom,
    );

    final openState = EdgeInsets.lerp(
      EdgeInsets.zero,
      multiOpen,
      twoPanelAmount,
    );

    final closedState = EdgeInsets.lerp(
      singlePanelState,
      multiPanelState,
      twoPanelAmount,
    );

    return EdgeInsets.lerp(closedState, openState, openAmount)!;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(omniBarStateProvider);
    final level = ref.watch(currentRouterLevelProvider);
    final isRoot = level == 0;
    final open = state.open || isRoot;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final colors = Theme.of(context).colorScheme;
    final panels = ref.watch(panelsProvider);
    final breakpoint = ref.watch(breakPointProvider);
    final barHeight = OmniBar.resolvedHeight(
      context,
      ref,
      open: open,
      searching: state.searching,
      docked: panels < 2,
      breakpoint: breakpoint,
    );

    final determinedCornerRadius = panels < 2
        ? BorderRadius.zero
        : open
            ? openCornerRadius.value(breakpoint)
            : cornerRadius.value(breakpoint);

    return Glass(
      duration: OmniBar.transitionDuration,
      state: panels < 2 && !open ? GlassState.opaque : GlassState.translucent,
      cornerRadius: determinedCornerRadius,
      blur: open ? 60 : glassBlur,
      color: open
          ? colors.surfaceVariant.withBrightness(isDark ? 0.5 : 1.5)
          : colors.background,
      transparency: glassTransparency,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: AnimatedOpacity(
              duration: OmniBar.transitionDuration,
              curve: pageTransitionCurve,
              opacity: open ? 1 : 0,
              child: OmniResults(
                barHeight: barHeight,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: panels > 1 ? 0 : null,
            bottom: panels < 2 ? 0 : null,
            child: AnimatedContainer(
              duration: OmniBar.transitionDuration,
              curve: pageTransitionCurve,
              height: barHeight,
              child: const OmniBar(),
            ),
          ),
        ],
      ),
    );
  }
}
