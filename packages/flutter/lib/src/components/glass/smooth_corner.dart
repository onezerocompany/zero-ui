import 'package:zero_ui/globals.dart';
import 'package:zero_ui/zero_ui.dart';
import 'package:smooth_corner/smooth_corner.dart';

class SmoothCorner extends ConsumerWidget {
  final Duration duration;
  final Curve curve;
  final BorderRadius cornerRadius;
  final Widget child;
  final Color? color;
  final BorderSide? side;
  final bool clip;
  final double elevation;

  const SmoothCorner({
    super.key,
    required this.cornerRadius,
    required this.child,
    this.duration = pageTransitionDuration,
    this.curve = pageTransitionCurve,
    this.color,
    this.side,
    this.clip = true,
    this.elevation = 0,
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
