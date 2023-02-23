import 'dart:math';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_flutter/zero_flutter.dart';

export 'multi_builder.dart';

class MultiPageScaffold extends ConsumerWidget {
  const MultiPageScaffold({
    super.key,
    required this.leftPage,
    required this.rightPage,
  });

  final Widget leftPage;
  final Widget rightPage;

  // the width of the left panel (which can overflow)
  double leftPageWidth(
    Size screenSize,
    Size scaffoldSize,
    double multiPage,
    double showingSecondPage,
  ) {
    final double minLeftWidth = min(screenSize.width, 330);
    const double maxLeftWidth = 500;

    final multiPageWidth = (scaffoldSize.width * 0.4).clamp(
      minLeftWidth,
      maxLeftWidth,
    );

    final secondPageWidth = lerpDouble(
      scaffoldSize.width - multiPageWidth,
      multiPageWidth,
      showingSecondPage,
    );

    // multipage is 0 means 100% scaffold width
    // multipage is 1 and showingSecondPage is 0 means 60% scaffold width
    // multipage is 1 and showingSecondPage is 1 means 40% scaffold width
    return lerpDouble(
          scaffoldSize.width,
          secondPageWidth ?? multiPageWidth,
          multiPage,
        ) ??
        scaffoldSize.width;
  }

  // the width of the viewport
  double leftViewportWidth(
    double leftPageWidth,
    double multiPage,
    double showingSecondPage,
  ) {
    // multipage is 0 and showingSecondPage is 0 means 100% leftPageWidth
    // multipage is 0 and showingSecondPage is 1 means 0
    // multipage is 1 and showingSecondPage is 0 means 100% leftPageWidth
    // multipage is 1 and showingSecondPage is 1 means 100% leftPageWidth
    final nonMultiPage = lerpDouble(
      leftPageWidth,
      0,
      showingSecondPage,
    );

    return lerpDouble(
          nonMultiPage ?? leftPageWidth,
          leftPageWidth,
          multiPage,
        ) ??
        0;
  }

  // left offset of the left viewport
  double leftViewportOffset(
    Size scaffoldSize,
    double leftPageWidth,
    double multiPage,
    double showingSecondPage,
  ) {
    // multipage is 0 and showingSecondPage is 0 means 0
    // multipage is 0 and showingSecondPage is 1 means 0
    // multipage is 1 and showingSecondPage is 1 means 0
    // multipage is 1 and showingSecondPage is 0 means 100% leftPageWidth
    final secondPage = lerpDouble(
      scaffoldSize.width - leftPageWidth,
      0,
      showingSecondPage,
    );

    return lerpDouble(
          0,
          secondPage ?? leftPageWidth,
          multiPage,
        ) ??
        0;
  }

  double rightPageWidth(
    Size scaffoldSize,
    double leftViewportWidth,
    double multiPage,
  ) {
    // multipage is 0 means scaffold width
    // multipage is 1 means 60% scaffold width
    return lerpDouble(
          scaffoldSize.width,
          max(scaffoldSize.width - leftViewportWidth, scaffoldSize.width * 0.6),
          multiPage,
        ) ??
        scaffoldSize.width;
  }

  double rightViewportWidth(
    Size scaffoldSize,
    double rightPageWidth,
    double leftViewportWidth,
    double multiPage,
  ) {
    // multipage is 1 means 100% rightPageWidth
    // multipage is 0 means scaffold width - leftPageWidth
    return lerpDouble(
          scaffoldSize.width - leftViewportWidth,
          rightPageWidth,
          multiPage,
        ) ??
        0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breakpoints =
        AdaptiveContext.of(context)?.breakPoints ?? const BreakPoints();
    final maxScaffoldWidth = breakpoints.points[BreakPoint.lg] ?? 1280;
    final screenSize = MediaQuery.of(context).size;
    final level = AppConfig.router(context).level;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxScaffoldWidth,
        ),
        child: MultiPageScaffoldBuilder(
          builder: (
            BuildContext context,
            MultiScaffoldState state,
            Size size,
            Widget? child,
          ) {
            final leftPageWidth = this.leftPageWidth(
              screenSize,
              size,
              state.multiPage,
              state.showingSecondPage,
            );
            final leftViewportWidth = this.leftViewportWidth(
              leftPageWidth,
              state.multiPage,
              state.showingSecondPage,
            );
            final leftViewportOffset = this.leftViewportOffset(
              size,
              leftPageWidth,
              state.multiPage,
              state.showingSecondPage,
            );
            final rightPageWidth = this.rightPageWidth(
              size,
              leftViewportWidth,
              state.multiPage,
            );
            final rightViewportWidth = this.rightViewportWidth(
              size,
              rightPageWidth,
              leftViewportWidth,
              state.multiPage,
            );

            return Stack(
              children: [
                Positioned(
                  left: leftViewportOffset,
                  top: 0,
                  bottom: 0,
                  width: leftViewportWidth,
                  child: SizedBox(
                    width: leftPageWidth,
                    height: size.height,
                    child: OverflowBox(
                      maxWidth: leftPageWidth,
                      minWidth: leftPageWidth,
                      maxHeight: size.height,
                      minHeight: size.height,
                      alignment: Alignment.centerRight,
                      child: leftPage,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: rightViewportWidth,
                  child: IgnorePointer(
                    ignoring: level < 2,
                    child: SizedBox(
                      width: rightPageWidth,
                      height: size.height,
                      child: OverflowBox(
                        maxWidth: rightPageWidth,
                        minWidth: rightPageWidth,
                        maxHeight: size.height,
                        minHeight: size.height,
                        alignment: Alignment.centerLeft,
                        child: rightPage,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
