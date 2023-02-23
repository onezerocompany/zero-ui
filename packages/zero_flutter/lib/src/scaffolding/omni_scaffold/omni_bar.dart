import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';

class OmniBar extends ConsumerStatefulWidget {
  const OmniBar({
    super.key,
    required this.height,
  });

  final double height;

  static const padding = AdaptiveValue<double>(
    defaultValue: 16,
    values: [],
  );

  static const Duration transitionDuration = Duration(milliseconds: 340);

  static double resolvedHeight(
    BuildContext context, {
    required bool open,
    required bool searching,
    required bool docked,
    required BreakPoint breakpoint,
  }) {
    final searchEnabled = AppConfig.of(context).searchEnabled();
    final panels = AdaptiveContext.panels(context);
    final breakpointPadding = padding.value(breakpoint);
    final searchHeight = OmniSearch.height.value(breakpoint);
    final buttonsHeight = OmniButtons.height.value(breakpoint);
    final safePadding = (docked ? MediaQuery.of(context).padding.bottom : 0);
    final mobileBar = !open && panels < 2;
    return (breakpointPadding *
            (searching || mobileBar || !searchEnabled ? 2 : 3)) +
        ((!mobileBar && searchEnabled) ? searchHeight : 0) +
        (!searching ? buttonsHeight : 0) +
        safePadding;
  }

  @override
  OmniBarState createState() => OmniBarState();
}

class OmniBarState extends ConsumerState<OmniBar> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final isRoot = ref.watch(Router.isRoot);
    final open = ref.watch(omniBarOpen) || isRoot;
    final breakpoint = AdaptiveContext.breakpoint(context);
    final searching = ref.watch(omniSearching);
    final panels = AdaptiveContext.panels(context);

    final padding = OmniBar.padding.value(breakpoint);
    final buttonsHeight = OmniButtons.height.value(breakpoint);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final searchEnabled = AppConfig.of(context).searchEnabled();

    return AnimatedGlass(
      state: open ? GlassState.translucent : GlassState.invisible,
      padding: EdgeInsets.all(padding),
      color: searching
          ? (isDark ? colors.surfaceVariant : colors.background)
          : colors.surface,
      transparency: open ? 0.2 : 0.7,
      child: SafeArea(
        top: false,
        bottom: panels < 2,
        left: panels < 2,
        right: panels < 2,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              height: buttonsHeight,
              left: 0,
              right: 0,
              child: AnimatedCrossFade(
                duration: OmniBar.transitionDuration,
                crossFadeState: searching
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstCurve: pageTransitionCurve,
                secondCurve: pageTransitionCurve,
                sizeCurve: pageTransitionCurve,
                firstChild: const OmniButtons(),
                secondChild: const SizedBox.shrink(),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedHider(
                visible: (panels > 1 || open) && searchEnabled,
                alignment: Alignment.bottomCenter,
                duration: OmniBar.transitionDuration,
                curve: pageTransitionCurve,
                secondChild: const SizedBox.shrink(),
                child: OmniSearch(
                  text: text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
