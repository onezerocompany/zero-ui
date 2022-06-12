import 'package:flutter/widgets.dart';
import 'package:zero_ui/zero_ui.dart';

class ZeroContainer extends StatelessWidget {
  const ZeroContainer({
    Key? key,
    this.style,
    this.theme,
    this.content,
  }) : super(
          key: key,
        );

  final ZeroStyle? style;
  final ZeroTheme? theme;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: style?.width ?? double.infinity,
      height: style?.height ?? double.infinity,
      margin: style?.margin,
      padding: style?.padding,
      constraints: style?.boxConstraints,
      decoration: style?.boxDecoration,
      child: Center(
        child: content,
      ),
    );
  }
}
