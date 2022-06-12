import 'package:flutter/widgets.dart';
import 'package:zero_ui/zero_ui.dart';

class ZeroText extends StatelessWidget {
  final String content;

  const ZeroText({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZeroContainer(
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
