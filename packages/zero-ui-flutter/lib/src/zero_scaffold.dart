import 'package:flutter/widgets.dart';
import 'package:zero_ui/zero_ui.dart';

class ZeroScaffold extends StatefulWidget {
  const ZeroScaffold({Key? key, this.theme, this.body}) : super(key: key);

  final ZeroTheme? theme;
  final Widget? body;

  @override
  State<ZeroScaffold> createState() => _ZeroScaffoldState();
}

class _ZeroScaffoldState extends State<ZeroScaffold> {
  @override
  Widget build(BuildContext context) {
    return ZeroContainer(
      theme: widget.theme,
      content: widget.body,
    );
  }
}
