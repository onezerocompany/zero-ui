import 'package:onezero/onezero.dart';
import 'package:flutter/widgets.dart' as flutter;

class Icon extends StatelessWidget {
  const Icon({
    super.key,
    required this.icon,
    this.color,
    this.style,
  });

  final IconData icon;
  final DynamicColor? color;
  final TypographyStyle? style;

  @override
  Widget build(BuildContext context) {
    final colors = ContainerColors.of(context);
    return flutter.Icon(
      icon,
      color: (color ?? colors.content).resolve(context),
      size: style?.font.iconSize ?? 24,
    );
  }
}
