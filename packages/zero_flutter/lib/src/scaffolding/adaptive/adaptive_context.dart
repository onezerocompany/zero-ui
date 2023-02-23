import 'package:flutter/material.dart';
import 'package:zero_flutter/zero_flutter.dart';

class AdaptiveContext extends InheritedWidget {
  final BreakPoints breakPoints;
  final BreakPoint _breakPoint;

  final int _panes;
  final bool _sidebar;

  const AdaptiveContext({
    super.key,
    required super.child,
    required BreakPoint breakpoint,
    required int panes,
    required bool showSidebar,
    required this.breakPoints,
  })  : _breakPoint = breakpoint,
        _panes = panes,
        _sidebar = showSidebar;

  @override
  bool updateShouldNotify(AdaptiveContext oldWidget) {
    return _breakPoint != oldWidget._breakPoint || _panes != oldWidget._panes;
  }

  static AdaptiveContext? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveContext>();
  }

  static BreakPoint breakpoint(BuildContext context) {
    return AdaptiveContext.of(context)?._breakPoint ?? BreakPoint.xxs;
  }

  static int panels(BuildContext context) {
    return AdaptiveContext.of(context)?._panes ?? 1;
  }

  static bool sidebar(BuildContext context) {
    return AdaptiveContext.of(context)?._sidebar ?? false;
  }
}

class AdaptiveContextProvider extends StatelessWidget {
  final Widget child;
  final BreakPoints breakPoints;

  const AdaptiveContextProvider({
    super.key,
    required this.child,
    this.breakPoints = const BreakPoints(),
  });

  static const panes = AdaptiveValue<int>(
    defaultValue: 1,
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
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final breakpoint = breakPoints.breakpoint(width);
    final panes = AdaptiveContextProvider.panes.value(breakpoint);
    return AdaptiveContext(
      breakPoints: breakPoints,
      breakpoint: breakpoint,
      panes: panes,
      showSidebar: panes > 1,
      child: child,
    );
  }
}
