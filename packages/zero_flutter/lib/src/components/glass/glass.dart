import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';

export 'blur.dart';
export 'smooth_corner.dart';

/// The state of the glass.
enum GlassState {
  /// The glass is completely opaque, e.g. a solid color.
  opaque,

  /// The glass is partially transparent, e.g. a translucent color and with a blur.
  translucent,

  /// The color remains but there is no blur.
  transparent,

  /// There is no glass, e.g. it only rounds the corners of the child.
  invisible,
}

class Glass extends StatelessWidget {
  final Duration duration;
  final Curve curve;
  final Widget? child;

  final GlassState state;
  final BorderRadius cornerRadius;
  final Color? color;
  final double? blur;
  final double? transparency;
  final EdgeInsets padding;
  final bool clip;
  final double borderWidth;
  final Color? borderColor;

  const Glass({
    super.key,
    required this.state,
    this.duration = pageTransitionDuration,
    this.curve = pageTransitionCurve,
    this.child,
    this.color,
    this.blur,
    this.transparency,
    this.padding = EdgeInsets.zero,
    this.cornerRadius = BorderRadius.zero,
    this.clip = true,
    this.borderWidth = 0,
    this.borderColor,
  });

  double get currentBlur {
    return state != GlassState.translucent ? 0 : (blur ?? glassBlur);
  }

  double get currentOpacity {
    switch (state) {
      case GlassState.opaque:
        return 1;
      case GlassState.translucent:
        return transparency ?? glassTransparency;
      case GlassState.transparent:
        return transparency ?? glassTransparency;
      case GlassState.invisible:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme colors = Theme.of(context).colorScheme;
    Color color = (this.color ?? colors.surface).withOpacity(currentOpacity);
    Color borderColor = this.borderColor ??
        colors.onBackground.withOpacity(
          isDark ? 0.1 : 0.2,
        );

    return SmoothCorner(
      duration: duration,
      curve: curve,
      cornerRadius: cornerRadius,
      clip: clip,
      side: borderWidth == 0
          ? BorderSide.none
          : BorderSide(
              color: borderColor,
              width: borderWidth,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
      child: Blur(
        duration: duration,
        curve: curve,
        blur: currentBlur,
        child: AnimatedContainer(
          duration: duration,
          curve: curve,
          color: color,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
