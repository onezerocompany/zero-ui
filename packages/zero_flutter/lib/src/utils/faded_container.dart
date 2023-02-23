import 'package:zero_flutter/zero_flutter.dart';

class FadedContainer extends StatelessWidget {
  const FadedContainer({
    super.key,
    required this.child,
    this.blur = EdgeInsets.zero,
    this.fade = EdgeInsets.zero,
  });

  final Widget child;
  final EdgeInsets blur;
  final EdgeInsets fade;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;

        // convert fade insets to 0-1 values

        var widget = child;

        if (fade.left != 0 || fade.right != 0) {
          final fadeLeft = fade.left / size.width;
          final fadeRight = fade.right / size.width;
          widget = ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: const [
                  Color(0x00FFFFFF),
                  Colors.white,
                  Colors.white,
                  Color(0x00FFFFFF),
                ],
                stops: [
                  0,
                  fadeLeft,
                  1 - fadeRight,
                  1,
                ],
              ).createShader(rect);
            },
            child: child,
          );
        }

        if (fade.top != 0 || fade.bottom != 0) {
          final fadeTop = fade.top / size.height;
          final fadeBottom = fade.bottom / size.height;
          widget = ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
                  Color(0x00FFFFFF),
                  Colors.white,
                  Colors.white,
                  Color(0x00FFFFFF),
                ],
                stops: [
                  0,
                  fadeTop,
                  1 - fadeBottom,
                  1,
                ],
              ).createShader(rect);
            },
            child: widget,
          );
        }

        if (blur != EdgeInsets.zero) {
          widget = Stack(
            fit: StackFit.passthrough,
            children: [
              widget,
              if (blur.left != 0)
                Positioned(
                  left: 0,
                  top: 5,
                  bottom: 5,
                  width: blur.left,
                  child: const BlurFader(
                    direction: BlurFaderDirection.rightToLeft,
                  ),
                ),
              if (blur.right != 0)
                Positioned(
                  right: 0,
                  top: 5,
                  bottom: 5,
                  width: blur.right,
                  child: const BlurFader(
                    direction: BlurFaderDirection.leftToRight,
                  ),
                ),
              if (blur.top != 0)
                Positioned(
                  left: 5,
                  top: 0,
                  right: 5,
                  height: blur.top,
                  child: const BlurFader(
                    direction: BlurFaderDirection.bottomToTop,
                  ),
                ),
              if (blur.bottom != 0)
                Positioned(
                  left: 5,
                  bottom: 0,
                  right: 5,
                  height: blur.bottom,
                  child: const BlurFader(
                    direction: BlurFaderDirection.topToBottom,
                  ),
                ),
            ],
          );
        }

        return widget;
      },
    );
  }
}
