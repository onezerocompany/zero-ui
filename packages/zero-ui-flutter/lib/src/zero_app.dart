import 'package:zero_ui/zero_ui.dart';
import 'package:flutter/widgets.dart';

class ZeroApp extends StatefulWidget {
  const ZeroApp({Key? key, this.theme, this.body}) : super(key: key);

  final ZeroTheme? theme;
  final Widget? body;

  @override
  State<ZeroApp> createState() => _ZeroAppState();
}

class _ZeroAppState extends State<ZeroApp> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: ZeroScaffold(theme: widget.theme, body: widget.body));
  }
}
