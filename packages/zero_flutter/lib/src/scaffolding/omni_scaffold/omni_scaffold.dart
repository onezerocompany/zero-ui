import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';
import 'package:zero_flutter/src/search_provider/search_container.dart';

export 'omni_bar.dart';
export 'omni_container.dart';
export 'omni_shortcuts.dart';
export 'omni_state.dart';
export 'omni_buttons.dart';
export 'omni_results.dart';
export 'omni_search.dart';

class ToggleOmniBarIntent extends Intent {
  const ToggleOmniBarIntent();
}

class CloseOmniBarIntent extends Intent {
  const CloseOmniBarIntent();
}

class OmniScaffold extends ConsumerWidget {
  final Widget child;

  const OmniScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final isRoot = ref.watch(Router.isRoot);
    final open = ref.watch(omniBarOpen) || isRoot;
    final searching = ref.watch(omniSearching);
    final panels = AdaptiveContext.panels(context);
    final height = MediaQuery.of(context).size.height;
    final breakpoint = AdaptiveContext.breakpoint(context);

    final barHeight = OmniBar.resolvedHeight(
      context,
      open: open,
      searching: searching,
      docked: panels < 2,
      breakpoint: breakpoint,
    );

    // get metadata of the current page
    final hideBar =
        AppConfig.router(context).currentPage(context)?.hideOmniBar == true;

    return SearchContainer(
      child: OmniBarShortcuts(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: colors.surface,
          body: LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.biggest;
              return TweenAnimationBuilder(
                duration: OmniBar.transitionDuration,
                curve: pageTransitionCurve,
                tween: Tween<double>(
                  begin: panels > 1 ? 1 : 0,
                  end: panels > 1 ? 1 : 0,
                ),
                builder: (context, twoPanelAmount, _) {
                  return TweenAnimationBuilder(
                    duration: OmniBar.transitionDuration,
                    curve: pageTransitionCurve,
                    tween: Tween<double>(
                      begin: open ? 1 : 0,
                      end: open ? 1 : 0,
                    ),
                    builder: (context, openAmount, _) {
                      final barPosition = OmniContainer.position(
                        context,
                        size: size,
                        openAmount: openAmount,
                        twoPanelAmount: twoPanelAmount,
                        keyboardHeight:
                            MediaQuery.of(context).viewInsets.bottom,
                        barHeight: barHeight,
                      );
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned.fill(
                            child: AppConfig.style(context)
                                    .background
                                    ?.call(context) ??
                                Container(),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: hideBar
                                ? 0
                                : clampDouble(
                                    lerpDouble(
                                          lerpDouble(
                                            height - barPosition.top,
                                            0,
                                            twoPanelAmount,
                                          ),
                                          0,
                                          openAmount,
                                        ) ??
                                        0,
                                    0,
                                    barHeight,
                                  ),
                            child: child,
                          ),
                          Positioned.fill(
                            child: IgnorePointer(
                              ignoring: !open,
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    ref.read(omniBarOpen.notifier).state =
                                        false;
                                  },
                                  child: AnimatedGlass(
                                    duration: OmniBar.transitionDuration,
                                    state: open
                                        ? GlassState.translucent
                                        : GlassState.invisible,
                                    blur: 40,
                                    color: colors.onSurface,
                                    transparency: 0.25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: barPosition.top,
                            left: barPosition.left,
                            right: barPosition.right,
                            bottom: barPosition.bottom +
                                (MediaQuery.of(context).viewInsets.bottom *
                                    openAmount),
                            child: IgnorePointer(
                              ignoring: hideBar,
                              child: AnimatedOpacity(
                                duration: OmniBar.transitionDuration,
                                opacity: hideBar ? 0 : 1,
                                child: OmniContainer(),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
