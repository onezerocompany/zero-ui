import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double size;
  final Color? color;
  final double? progress;

  const Loader({
    super.key,
    this.size = 24,
    this.color,
    this.progress,
  });

  // animate the loader if progress is provided
  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    Color color = this.color ?? colors.onBackground;

    if (progress == null) {
      return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          backgroundColor: color.withOpacity(0.1),
          strokeWidth: size / 13,
          color: color,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    } else {
      return SizedBox(
        width: size,
        height: size,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          tween: Tween<double>(begin: 0, end: progress?.clamp(0, 1) ?? 0),
          builder: (context, value, child) {
            return CircularProgressIndicator(
              value: value,
              backgroundColor: color.withOpacity(0.1),
              strokeWidth: size / 13,
              color: color,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            );
          },
        ),
      );
    }
  }
}
