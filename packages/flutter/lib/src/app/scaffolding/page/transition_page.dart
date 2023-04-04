import 'package:go_router/go_router.dart';
import 'package:zero_ui/globals.dart';
import 'package:zero_ui/zero_ui.dart';

class TransitionPage extends CustomTransitionPage {
  static const AdaptiveValue<bool> shouldTransition = AdaptiveValue<bool>(
    fallbackValue: false,
    values: [
      AdaptiveRangedValue(
        minBreakpoint: BreakPoint.md,
        value: true,
      ),
    ],
  );

  final AxisDirection? inDirection;
  final AxisDirection? outDirection;
  final RouterEntry? entry;

  TransitionPage({
    required super.key,
    required super.name,
    required super.child,
    required int level,
    this.inDirection,
    this.outDirection,
    this.entry,
  }) : super(
          restorationId: entry?.fullPath ?? key.toString(),
          transitionDuration: pageTransitionDuration,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            final breakpoint = globalContainer.read(breakPointProvider);
            final shouldTransition =
                TransitionPage.shouldTransition.value(breakpoint) || level <= 1;
            if (!shouldTransition) {
              return child;
            } else {
              return ClipRect(
                child: SlideTransition(
                  position: Tween(
                    begin: Offset(
                      inDirection == AxisDirection.left
                          ? 1
                          : (inDirection == AxisDirection.right ? -1 : 0),
                      inDirection == AxisDirection.up
                          ? 1
                          : (inDirection == AxisDirection.down ? -1 : 0),
                    ),
                    end: Offset.zero,
                  )
                      .chain(CurveTween(curve: pageTransitionCurve))
                      .animate(animation),
                  child: SlideTransition(
                    position: Tween(
                      begin: Offset.zero,
                      end: Offset(
                        outDirection == AxisDirection.left
                            ? -1
                            : (outDirection == AxisDirection.right ? 1 : 0),
                        outDirection == AxisDirection.up
                            ? -1
                            : (outDirection == AxisDirection.down ? 1 : 0),
                      ),
                    )
                        .chain(CurveTween(curve: pageTransitionCurve))
                        .animate(secondaryAnimation),
                    child: child,
                  ),
                ),
              );
            }
          },
        );
}
