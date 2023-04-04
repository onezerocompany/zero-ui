import 'package:zero_ui/zero_ui.dart';

enum ButtonSize {
  small,
  medium,
  large,
}

class ButtonStateConfig {
  final double brightness;
  final double scale;
  final double opacity;

  const ButtonStateConfig({
    this.brightness = 1,
    this.scale = 1,
    this.opacity = 1,
  });
}

class ButtonConfig {
  const ButtonConfig({
    this.size = ButtonSize.medium,
    this.fillWidth = false,
    contentColor,
    this.fillColor,
    this.transparency = 0,
    this.hoverBackground = false,
    this.glassLike = false,
    this.cornerRadii = const {
      ButtonSize.small: BorderRadius.zero,
      ButtonSize.medium: BorderRadius.zero,
      ButtonSize.large: BorderRadius.zero,
    },
    this.paddings = const {
      ButtonSize.small: EdgeInsets.zero,
      ButtonSize.medium: EdgeInsets.zero,
      ButtonSize.large: EdgeInsets.zero,
    },
    this.textIconSizes = const {
      ButtonSize.small: 15,
      ButtonSize.medium: 18,
      ButtonSize.large: 24,
    },
    this.states = const {
      ButtonState.hover: ButtonStateConfig(
        scale: 1.015,
        brightness: 1.1,
        opacity: 0.8,
      ),
      ButtonState.pressed: ButtonStateConfig(
        scale: 0.98,
        brightness: 0.9,
        opacity: 0.4,
      ),
      ButtonState.disabled: ButtonStateConfig(
        brightness: 1,
        opacity: 0.3,
      ),
      ButtonState.loading: ButtonStateConfig(
        brightness: 0.9,
        opacity: 0.9,
      ),
    },
    this.haptic = true,
    this.borderColor,
    this.borderWidth = 0,
  }) : _contentColor = contentColor;

  // global style
  final ButtonSize size;
  final bool fillWidth;
  final Color? _contentColor;
  final Color? fillColor;
  final double transparency;
  final bool hoverBackground;
  final bool glassLike;
  final Color? borderColor;
  final double borderWidth;

  // sized style
  final Map<ButtonSize, BorderRadius> cornerRadii;
  final Map<ButtonSize, EdgeInsets> paddings;
  final Map<ButtonSize, double> textIconSizes;

  // state style
  final Map<ButtonState, ButtonStateConfig> states;

  // feedback
  final bool haptic;

  copyWith({
    ButtonSize? size,
    bool? fillWidth,
    Color? contentColor,
    Color? fillColor,
    double? transparency,
    bool? hoverBackground,
    Map<ButtonSize, BorderRadius>? cornerRadii,
    Map<ButtonSize, EdgeInsets>? paddings,
    Map<ButtonSize, double>? textIconSizes,
    Map<ButtonState, ButtonStateConfig>? states,
    bool? haptic,
    bool? glassLike,
    Color? borderColor,
    double? borderWidth,
  }) {
    return ButtonConfig(
      size: size ?? this.size,
      fillWidth: fillWidth ?? this.fillWidth,
      contentColor: contentColor ?? _contentColor,
      fillColor: fillColor ?? this.fillColor,
      transparency: transparency ?? this.transparency,
      hoverBackground: hoverBackground ?? this.hoverBackground,
      cornerRadii: cornerRadii ?? this.cornerRadii,
      paddings: paddings ?? this.paddings,
      textIconSizes: textIconSizes ?? this.textIconSizes,
      states: states ?? this.states,
      haptic: haptic ?? this.haptic,
      glassLike: glassLike ?? this.glassLike,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }

  Color fillColorForState(ButtonState state, BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color determinedColor = fillColor ?? colorScheme.primary;
    // return if the buton is not filled
    if (transparency > 0) {
      if (state == ButtonState.hover && hoverBackground) {
        return colorScheme.onBackground.withOpacity(0.05);
      }
      return determinedColor.withOpacity(1 - transparency);
    }

    // load the config for the state
    ButtonStateConfig? stateConfig = states[state];

    // return the default color if no config is found
    // or if the config has no brightness change
    if (stateConfig == null || stateConfig.brightness == 1) {
      return determinedColor.withOpacity(glassLike ? 0.8 : 1);
    }

    return determinedColor
        .withBrightness(stateConfig.brightness)
        .withOpacity(glassLike ? 0.8 : 1);
  }

  Color contentColor(BuildContext context) {
    if (_contentColor != null) return _contentColor!;

    if (transparency == 0) {
      return (fillColorForState(ButtonState.idle, context)).foreground;
    } else {
      return Theme.of(context).colorScheme.onBackground;
    }
  }

  double scaleForState(ButtonState state) {
    return states[state]?.scale ?? 1;
  }

  double opacityForState(ButtonState state) {
    return states[state]?.opacity ?? 1;
  }

  BorderRadius get cornerRadius {
    return cornerRadii[size] ?? BorderRadius.zero;
  }

  EdgeInsets get padding {
    return paddings[size] ?? EdgeInsets.zero;
  }

  double get textIconSize {
    return textIconSizes[size] ?? 12;
  }
}
