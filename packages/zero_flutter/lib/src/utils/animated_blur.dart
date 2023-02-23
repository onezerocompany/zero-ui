import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zero_flutter/globals.dart';

class AnimatedBlur extends StatelessWidget {
  final Duration duration;
  final Curve curve;
  final Widget child;

  final double blur;

  const AnimatedBlur({
    super.key,
    this.duration = pageTransitionDuration,
    this.curve = pageTransitionCurve,
    required this.child,
    this.blur = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(
        begin: blur,
        end: blur,
      ),
      duration: duration,
      builder: (context, double value, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: value,
            sigmaY: value,
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}
