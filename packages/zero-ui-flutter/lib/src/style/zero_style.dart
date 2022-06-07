import 'package:flutter/widgets.dart';
import 'package:zero_ui/zero_ui.dart';

enum ZeroContainerSizing {
  fill,
  content,
}

class ZeroStyle {
  final BuildContext context;
  final ZeroContainerSizing sizing;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;
  final double? width;
  final double? height;
  final double? elevation;

  BoxDecoration get boxDecoration {
    return BoxDecoration(
      color: ZeroTheme.of(context).backgroundColor,
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
    this.color = const Color(0x00000000),
    this.width,
    this.height,
    this.elevation,
  });
}
