import 'package:flutter/widgets.dart';
import 'package:zero_ui/zero_ui.dart';

enum ZeroContainerSizing {
  fill,
  content,
}

class ZeroStyle {
  final BuildContext? context;
  final ZeroContainerSizing sizing;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final ZeroColor color;
  final double? width;
  final double? height;
  final double? elevation;

  TextStyle get textStyle {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  BoxDecoration get boxDecoration {
    ZeroTheme theme =
        context?.findAncestorWidgetOfExactType<ZeroScaffold>()?.theme ??
            const ZeroTheme();
    return BoxDecoration(
      color: theme.colors.surface.color,
    );
  }

  BoxConstraints get boxConstraints {
    switch (sizing) {
      case ZeroContainerSizing.fill:
        return const BoxConstraints.expand();
      case ZeroContainerSizing.content:
        return BoxConstraints.loose(Size.infinite);
    }
  }

  ZeroStyle({
    this.sizing = ZeroContainerSizing.fill,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.color = const ZeroColor(),
    this.width,
    this.height,
    this.elevation,
    this.context,
  });
}
