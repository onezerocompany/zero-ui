import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/src/scaffolding/omni_scaffold/omni_bar_state.dart';
import 'package:zero_flutter/zero_flutter.dart';

class OmniBar extends ConsumerWidget {
  const OmniBar({
    super.key,
  });

  static const double padding = 16;
  static const Duration transitionDuration = Duration(milliseconds: 340);

  static double resolvedHeight(
    BuildContext context,
    WidgetRef ref, {
    required bool open,
    required bool searching,
    required bool docked,
    required BreakPoint breakpoint,
  }) {
    final omniConfig = ref.watch(omniConfigProvider);
    final panels = ref.watch(panelsProvider);

    final safePadding = (docked ? MediaQuery.of(context).padding.bottom : 0);
    final mobileBar = !open && panels < 2;
    return (padding *
            (searching || mobileBar || !omniConfig.searchEnabled ? 2 : 3)) +
        ((!mobileBar && omniConfig.searchEnabled) ? OmniSearch.height : 0) +
        (!searching ? OmniButtons.height : 0) +
        safePadding;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(currentRouterLevelProvider);
    final isRoot = level == 0;
    final open = ref.watch(omniBarStateProvider).open || isRoot;
    final panels = ref.watch(panelsProvider);
    final searching = ref.watch(omniSearchingProvider);

    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final omniConfig = ref.watch(omniConfigProvider);
    final searchEnabled = omniConfig.searchEnabled;

    return AnimatedGlass(
      state: open ? GlassState.translucent : GlassState.invisible,
      padding: const EdgeInsets.all(padding),
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
              height: OmniButtons.height,
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
                child: const OmniSearch(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
