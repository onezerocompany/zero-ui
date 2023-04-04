import 'package:zero_ui/zero_ui.dart';

class AnimatedHider extends StatelessWidget {
  const AnimatedHider({
    super.key,
    required this.child,
    required this.visible,
    this.secondChild,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final Widget? secondChild;
  final bool visible;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    // make sure that both children fill the width
    // use eased curves for size and opacity
    return AnimatedCrossFade(
      firstChild: SizedBox(
        width: double.infinity,
        child: child,
      ),
      secondChild: SizedBox(
        width: double.infinity,
        height: secondChild == null ? 0 : null,
        child: secondChild,
      ),
      crossFadeState:
          visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: duration,
      sizeCurve: curve,
      firstCurve: curve,
      secondCurve: curve,
      alignment: alignment,
    );
  }
}
