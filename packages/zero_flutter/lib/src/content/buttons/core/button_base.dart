import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zero_flutter/zero_flutter.dart';

enum ButtonState {
  idle,
  hover,
  pressed,
  disabled,
  loading,
}

class ButtonBase extends StatefulWidget {
  final String? link;
  final VoidCallback? onPressed;
  final ButtonConfig config;

  // state
  final bool disabled;
  final bool loading;

  const ButtonBase({
    super.key,
    required this.disabled,
    required this.loading,
    required this.config,
    this.onPressed,
    this.link,
  });

  static const Duration animationDuration = Duration(milliseconds: 150);
  static const Curve animationCurve = Curves.fastOutSlowIn;

  Widget buildButton(
    BuildContext context,
    ButtonState state,
  ) {
    return Container();
  }

  @override
  State<ButtonBase> createState() => ButtonBaseState();
}

class ButtonBaseState extends State<ButtonBase> {
  bool hover = false;
  bool pressed = false;

  ButtonState get state {
    if (widget.disabled) return ButtonState.disabled;
    if (widget.loading) return ButtonState.loading;
    if (pressed) return ButtonState.pressed;
    if (hover) return ButtonState.hover;
    return ButtonState.idle;
  }

  bool get shouldRespond {
    return [
      ButtonState.idle,
      ButtonState.hover,
      ButtonState.pressed,
    ].contains(state);
  }

  GlassState get glassState {
    if (widget.config.glassLike) return GlassState.translucent;
    if (widget.config.transparency > 0) return GlassState.transparent;
    return GlassState.opaque;
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = widget.config.fillColorForState(state, context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (_) {
        setState(() {
          hover = true;
        });
      },
      onExit: (_) {
        setState(() {
          hover = false;
        });
      },
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            pressed = true;
          });
          if (widget.config.haptic && shouldRespond) {
            HapticFeedback.selectionClick();
          }
        },
        onTapUp: (_) {
          setState(() {
            pressed = false;
          });
          if (shouldRespond) {
            if (widget.config.haptic) HapticFeedback.lightImpact();
            widget.onPressed?.call();
            if (widget.link != null &&
                AppConfig.router(context).currentPath != widget.link) {
              AppConfig.router(context).go(widget.link!);
            }
          }
        },
        onTapCancel: () {
          setState(() {
            pressed = false;
          });
        },
        child: AnimatedScale(
          duration: ButtonBase.animationDuration,
          curve: ButtonBase.animationCurve,
          scale: widget.config.scaleForState(state),
          child: AnimatedGlass(
            state: glassState,
            duration: ButtonBase.animationDuration,
            curve: ButtonBase.animationCurve,
            borderWidth: widget.config.borderWidth,
            borderColor: widget.config.borderColor,
            cornerRadius: AdaptiveValue.fixed<BorderRadius>(
              widget.config.cornerRadius,
            ),
            color: fillColor,
            transparency: fillColor.opacity,
            padding: widget.config.padding,
            child: AnimatedOpacity(
              duration: ButtonBase.animationDuration,
              curve: ButtonBase.animationCurve,
              opacity: widget.config.opacityForState(state),
              child: widget.buildButton(context, state),
            ),
          ),
        ),
      ),
    );
  }
}
