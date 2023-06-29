import 'package:flutter/widgets.dart' as flutter;
import '../../onezero.dart';

/// A widget that displays a string of text with a given style.
///
/// The `Text` widget is used to display a string of text with a given style. It
/// can be customized with a variety of options including font family, font size,
/// font weight, letter spacing, word spacing, and color. The `Text` widget can
/// also be truncated to a specified number of lines if it exceeds a certain
/// height.
///
/// Example usage:
///
///
class Text extends StatelessWidget {
  const Text(
    this.text, {
    super.key,
    this.style = const TypographyStyle(),
    this.maxLines = 1,
    this.selectionColor,
    this.color,
    this.priority = ColorPriority.primary,
  });

  final String text;
  final TypographyStyle style;
  final int maxLines;
  final DynamicColor? selectionColor;
  final DynamicColor? color;
  final ColorPriority priority;

  @override
  Widget build(BuildContext context) {
    final colors = ContainerColors.of(context);
    return flutter.Text(
      text,
      style: style.style(
        context,
        color: color ?? colors.content,
      ),
      selectionColor: selectionColor?.resolve(context),
      overflow: TextOverflow.fade,
    );
  }

  factory Text.localized(
    BuildContext context, {
    required String scope,
    required String key,
    TypographyStyle? style,
    int? maxLines,
  }) {
    final text = LocalizationRegistry.of(context)
        .getLocalizedString(scope: scope, key: key);
    return Text(
      text,
      key: Key('$scope.$key'),
      style: style ?? const TypographyStyle(),
      maxLines: maxLines ?? 1,
    );
  }
}
