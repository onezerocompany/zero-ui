import 'package:flutter/widgets.dart';
import 'package:zero_ui/zero_ui.dart';

class ZeroScaffold extends StatefulWidget {
  const ZeroScaffold({Key? key, this.theme, this.content, this.appBar})
      : super(key: key);

  final ZeroTheme? theme;
  final Widget? content;
  final Widget? appBar;

  @override
  State<ZeroScaffold> createState() => _ZeroScaffoldState();
}

class _ZeroScaffoldState extends State<ZeroScaffold> {
  @override
  Widget build(BuildContext context) {
    return ZeroContainer(
      theme: widget.theme,
      content: ZeroContainer(
        content: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            ZeroContainer(
              content: Container(
                color: widget.theme?.colors.surface.color,
                constraints: const BoxConstraints.expand(),
              ),
            ),
            SafeArea(
              child: ZeroContainer(
                // margin: const EdgeInsets.symmetric(horizontal: 12),
                // decoration: const BoxDecoration(
                //   color: Color.fromARGB(255, 202, 89, 89),
                //   borderRadius: BorderRadius.all(Radius.circular(12)),
                // ),
                // constraints: const BoxConstraints.expand(height: 80),
                content: widget.content ?? const Text('Top bar'),
                style: ZeroStyle(
                  height: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
