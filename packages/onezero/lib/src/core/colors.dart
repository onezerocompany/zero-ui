import 'package:flutter/widgets.dart';

import '../../core.dart';

/// An enum that represents the different states that a color can have.
enum ColorState {
  /// The normal state of a color.
  normal,

  /// The state of a color when it is being hovered over.
  hover,

  /// The state of a color when it is being focused.
  focus,

  /// The state of a color when it is being pressed.
  active,

  /// The state of a color when it is disabled.
  disabled,
}

/// An enum that represents the different priorities that a color can have.
enum ColorPriority {
  /// The primary priority of a color.
  primary,

  /// The secondary priority of a color.
  secondary,

  /// The tertiary priority of a color.
  tertiary,
}

typedef DynamicColorMap
    = Map<ColorState, Map<ColorPriority, Map<ThemeBrightness, Color>>>;

class DynamicColor {
  DynamicColor({
    Color? lightRootColor,
    Color? darkRootColor,
  }) {
    final lightColor = lightRootColor ?? const Color(0xFF000000);
    final darkColor = darkRootColor ?? lightColor.inverted;
    _colors = {
      ColorState.normal:
          colorsForState(ColorState.normal, lightColor, darkColor),
      ColorState.hover: colorsForState(ColorState.hover, lightColor, darkColor),
      ColorState.focus: colorsForState(ColorState.focus, lightColor, darkColor),
      ColorState.active:
          colorsForState(ColorState.active, lightColor, darkColor),
      ColorState.disabled:
          colorsForState(ColorState.disabled, lightColor, darkColor),
    };
  }

  late final DynamicColorMap _colors;

  static Map<ColorPriority, Map<ThemeBrightness, Color>> colorsForState(
    ColorState state,
    Color lightRootColor,
    Color darkRootColor,
  ) {
    Color light = lightRootColor;
    Color dark = darkRootColor;

    switch (state) {
      case ColorState.normal:
        break;
      case ColorState.hover:
        light = lightRootColor.withBrightness(0.9);
        dark = darkRootColor.withBrightness(1.1);
        break;
      case ColorState.focus:
        light = lightRootColor.withBrightness(0.95);
        dark = darkRootColor.withBrightness(1.1);
        break;
      case ColorState.active:
        light = lightRootColor.withBrightness(1.1);
        dark = darkRootColor.withBrightness(0.95);
        break;
      case ColorState.disabled:
        light = lightRootColor.withBrightness(0.5);
        dark = darkRootColor.withBrightness(0.5);
        break;
    }

    return {
      ColorPriority.primary:
          colorsForPriority(ColorPriority.primary, light, dark),
      ColorPriority.secondary:
          colorsForPriority(ColorPriority.secondary, light, dark),
      ColorPriority.tertiary:
          colorsForPriority(ColorPriority.tertiary, light, dark),
    };
  }

  static Map<ThemeBrightness, Color> colorsForPriority(
    ColorPriority priority,
    Color lightRootColor,
    Color darkRootColor,
  ) {
    switch (priority) {
      case ColorPriority.primary:
        return {
          ThemeBrightness.light: lightRootColor,
          ThemeBrightness.dark: darkRootColor,
        };
      case ColorPriority.secondary:
        return {
          ThemeBrightness.light: lightRootColor.withBrightness(1.03),
          ThemeBrightness.dark: darkRootColor.withBrightness(0.8),
        };
      case ColorPriority.tertiary:
        return {
          ThemeBrightness.light: lightRootColor.withBrightness(1.06),
          ThemeBrightness.dark: darkRootColor.withBrightness(0.6),
        };
    }
  }

  /// Resolves this `DynamicColor` to either the light or dark color based on the platform brightness.
  Color resolve(
    BuildContext context, {
    ColorState state = ColorState.normal,
    ColorPriority priority = ColorPriority.primary,
    ThemeBrightness? brightness,
  }) {
    final resolvedBrightness = brightness ?? ZeroTheme.brightness(context);
    final resolvedState = _colors[state] ?? {};
    final resolvedPriority = resolvedState[priority] ?? {};
    final resolvedColor =
        resolvedPriority[resolvedBrightness] ?? const Color(0xFF000000);
    return resolvedColor;
  }
}

/// A class that defines colors for a container widget.
///
/// It takes four colors as arguments: surface, content, divider and edge.
/// The `surface` color is the background color of the container.
/// The `content` color is the color of the content inside the container.
/// The `divider` color is the color of the divider between different sections of the container.
/// The `edge` color is the color of the edge of the container.
///
/// Example usage:
///
/// ```dart
/// const ContainerColors myColors = ContainerColors(
///   surface: DynamicColor( ... ),
///   content: ContentColors( ... ),
///   divider: DynamicColor( ... ),
///   edge: DynamicColor( ... ),
/// );
/// ```
class ContainerColors {
  const ContainerColors({
    required this.surface,
    required this.content,
    required this.divider,
    required this.edge,
  });

  /// The surface color of this `ContainerColors` object.
  final DynamicColor surface;

  /// The content colors of this `ContainerColors` object.
  final DynamicColor content;

  /// The divider color of this `ContainerColors` object.
  final DynamicColor divider;

  /// The edge color of this `ContainerColors` object
  final DynamicColor edge;

  static ContainerColors of(BuildContext context) {
    final view = ContainerColorsScope.of(context);
    return view?.colors ??
        ContainerColors.fromRootColor(
          const Color(0xFF000000),
        );
  }

  static ContainerColors fromRootColor(
    Color color, {
    double colorSpacing = 0.05,
  }) {
    return ContainerColors(
      surface: DynamicColor(
        lightRootColor: color,
      ),
      content: DynamicColor(
        lightRootColor: color.inverted,
      ),
      divider: DynamicColor(
        lightRootColor: color.withBrightness(1 - colorSpacing * 2),
      ),
      edge: DynamicColor(
        lightRootColor: color.withBrightness(1 - (colorSpacing / 1.5)),
      ),
    );
  }
}

/// A class that defines a color theme for a UI.
///
/// It takes four `ContainerColors` objects as arguments: `scaffold`, `page`, `card`, and `dialog`.
/// The `scaffold` color is the background color of the entire UI.
/// The `page` color is the background color of a page in the UI.
/// The `card` color is the background color of a card in the UI.
/// The `dialog` color is the background color of a dialog in the UI.
///
/// Example usage:
///
/// ```dart
/// const ColorTheme myTheme = ColorTheme(
///   scaffold: ContainerColors( ... ),
///   page: ContainerColors( ... ),
///   card: ContainerColors( ... ),
///   dialog: ContainerColors( ... ),
/// );
/// ```
class ColorTheme {
  const ColorTheme({
    required this.scaffold,
    required this.page,
    required this.card,
  });

  /// The scaffold colors of this `ColorTheme` object.
  final ContainerColors scaffold;

  /// The page colors of this `ColorTheme` object.
  final ContainerColors page;

  /// The card colors of this `ColorTheme` object.
  final ContainerColors card;

  /// Generates a `ColorTheme` object from a root color.
  /// The `scaffold` light color is the root color.
  static ColorTheme fromRootColor(
    Color color, {
    double colorSpacing = 0.05,
  }) {
    return ColorTheme(
      scaffold: ContainerColors.fromRootColor(color),
      page: ContainerColors.fromRootColor(
        color.withBrightness(1 - colorSpacing),
      ),
      card: ContainerColors.fromRootColor(
        color.withBrightness(1 - colorSpacing * 1.5),
      ),
    );
  }
}

class ContainerColorsScope extends InheritedWidget {
  final ContainerColors colors;

  const ContainerColorsScope({
    Key? key,
    required this.colors,
    required Widget child,
  }) : super(key: key, child: child);

  static ContainerColorsScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ContainerColorsScope>();
  }

  @override
  bool updateShouldNotify(ContainerColorsScope oldWidget) {
    return colors != oldWidget.colors;
  }
}

extension ColorTools on Color {
  Color get inverted {
    return Color.fromARGB(
      alpha,
      red ^ 0xFF,
      green ^ 0xFF,
      blue ^ 0xFF,
    );
  }

  Color withBrightness(double brightness) {
    return Color.fromARGB(
      alpha.clamp(0, 255),
      (red * brightness).round().clamp(0, 255),
      (green * brightness).round().clamp(0, 255),
      (blue * brightness).round().clamp(0, 255),
    );
  }

  Color merged(Color accent, {double amount = 0.01}) {
    return Color.fromARGB(
      alpha,
      (red + (accent.red - red) * amount).round().clamp(0, 255),
      (green + (accent.green - green) * amount).round().clamp(0, 255),
      (blue + (accent.blue - blue) * amount).round().clamp(0, 255),
    );
  }

  Color altered({
    bool inverted = false,
    double brightnessStepDelta = 0.05,
    double brightnessSteps = 0,
    Color? accent,
    double accentAmount = 0.01,
  }) {
    Color result = this;
    if (inverted) result = result.inverted;
    if (brightnessSteps != 0) {
      result = result.withBrightness(brightnessSteps * brightnessStepDelta);
    }
    if (accent != null) {
      result = result.merged(accent, amount: accentAmount);
    }
    return result;
  }
}
