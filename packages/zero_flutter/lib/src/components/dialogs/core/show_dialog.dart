import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';

Future<dynamic> showDialog(
  Widget dialog,
) async {
  final scaffoldContext = oneZeroNav.currentContext;
  if (scaffoldContext == null) return null;

  final colors = Theme.of(scaffoldContext).colorScheme;
  final isDark = Theme.of(scaffoldContext).brightness == Brightness.dark;

  return await Navigator.of(scaffoldContext).push(
    PageRouteBuilder(
      settings: const RouteSettings(),
      opaque: false,
      transitionDuration: pageTransitionDuration,
      reverseTransitionDuration: pageTransitionDuration,
      fullscreenDialog: true,
      barrierDismissible: true,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        var tween = Tween<double>(begin: 0, end: 1)
            .chain(
              CurveTween(curve: pageTransitionCurve),
            )
            .animate(animation);
        return AnimatedBuilder(
          animation: tween,
          builder: (context, child) {
            // map the animation value to a color
            final color = ColorTween(
                  begin: colors.surface
                      .withBrightness(isDark ? 1.2 : 0.5)
                      .withOpacity(0),
                  end: colors.surface
                      .withBrightness(isDark ? 1.2 : 0.5)
                      .withOpacity(0.15),
                ).animate(tween).value ??
                colors.onBackground.withOpacity(0);

            return BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 40 * (tween.value).clamp(0.01, 1),
                sigmaY: 40 * (tween.value).clamp(0.01, 1),
              ),
              child: ColoredBox(
                color: color,
                child: child,
              ),
            );
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Dismissible(
                    dragStartBehavior: DragStartBehavior.down,
                    behavior: HitTestBehavior.translucent,
                    key: const ValueKey('dialog'),
                    direction: DismissDirection.down,
                    onDismissed: (direction) {
                      Navigator.of(context).pop();
                    },
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      )
                          .chain(CurveTween(curve: pageTransitionCurve))
                          .animate(animation),
                      child: dialog,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
