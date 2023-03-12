import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';
import 'package:smooth_corner/smooth_corner.dart';

class AnimatedSmoothCorner extends ConsumerWidget {
  final Duration duration;
  final Curve curve;
  final BorderRadius cornerRadius;
  final Widget child;
  final Color? color;
  final BorderSide? side;
  final bool clip;

  const AnimatedSmoothCorner({
    super.key,
    required this.cornerRadius,
    required this.child,
    this.duration = pageTransitionDuration,
    this.curve = pageTransitionCurve,
    this.color,
    this.side,
    this.clip = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TweenAnimationBuilder<BorderRadius>(
      duration: duration,
      curve: curve,
      tween: Tween<BorderRadius>(
        begin: cornerRadius,
        end: cornerRadius,
      ),
      builder: (
        BuildContext context,
        BorderRadius value,
        Widget? child,
      ) {
        return clip
            ? SmoothClipRRect(
                smoothness: smoothness,
                side: side ?? BorderSide.none,
                borderRadius: value,
                child: ColoredBox(
                  color: color ?? Colors.transparent,
                  child: child!,
                ),
              )
            : child!;
      },
      child: child,
    );
  }
}
