import 'package:zero_flutter/zero_flutter.dart';

class PulsingWidget extends HookWidget {
  const PulsingWidget({
    super.key,
    required this.child,
    required this.duration,
    required this.minOpacity,
  });

  final Widget child;
  final Duration duration;
  final double minOpacity;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: duration);
    final animation = useAnimation(
      Tween<double>(begin: 1, end: minOpacity).animate(animationController),
    );

    useEffect(
      () {
        animationController.repeat(reverse: true);
        return () => animationController.dispose();
      },
      [animationController],
    );

    return AnimatedBuilder(
      animation:
          Tween<double>(begin: 1, end: minOpacity).animate(animationController),
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: animation,
          child: child,
        );
      },
      child: child,
    );
  }
}
