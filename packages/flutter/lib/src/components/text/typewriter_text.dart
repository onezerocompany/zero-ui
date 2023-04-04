import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TypewriterText extends HookWidget {
  final String text;
  final Duration duration;
  final TextStyle? style;

  const TypewriterText({
    Key? key,
    required this.text,
    this.duration = const Duration(milliseconds: 50),
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = useState<int>(0);
    final visibleText = useState<String>('');
    final width = useState<double>(0);

    useEffect(
      () {
        final timer = Timer.periodic(duration, (timer) {
          final newText = _getNextText(visibleText.value, text);

          if (newText != visibleText.value) {
            visibleText.value = newText;
            index.value = (index.value + 1) % text.length;
            width.value = _measureTextWidth(visibleText.value, style);
          } else {
            timer.cancel();
          }
        });

        return () {
          timer.cancel();
        };
      },
      [text],
    );

    return AnimatedContainer(
      duration: duration,
      width: width.value,
      child: Text(
        visibleText.value,
        overflow: TextOverflow.visible,
        maxLines: 1,
        style: style,
      ),
    );
  }

  String _getNextText(String current, String target) {
    if (current == target) return current;

    final minLength =
        current.length < target.length ? current.length : target.length;
    int commonPrefixLength = 0;

    for (int i = 0; i < minLength; i++) {
      if (current[i] == target[i]) {
        commonPrefixLength++;
      } else {
        break;
      }
    }

    if (current.length > commonPrefixLength) {
      return current.substring(0, current.length - 1);
    } else {
      return target.substring(0, commonPrefixLength + 1);
    }
  }

  double _measureTextWidth(String text, TextStyle? style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width;
  }
}
