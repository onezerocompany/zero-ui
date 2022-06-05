import 'package:flutter/widgets.dart';
import 'package:zero_ui/zero_ui.dart';

class ZeroContainer extends StatelessWidget {
  const ZeroContainer({
    Key? key,
    this.content,
    this.theme,
  }) : super(
          key: key,
        );

  final ZeroTheme? theme;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Color(theme?.colors.surface.color ?? 0x00000000),
      child: Center(child: content),
    );
  }
}
