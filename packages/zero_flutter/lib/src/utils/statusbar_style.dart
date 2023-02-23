import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

enum StatusBarStyle {
  light,
  dark,
}

class StatusBarHelper extends StatelessWidget {
  final Widget child;
  final StatusBarStyle style;

  const StatusBarHelper({
    super.key,
    this.style = StatusBarStyle.light,
    this.child = const SizedBox.shrink(),
  });

  copyWith({
    Widget? child,
    StatusBarStyle? style,
  }) {
    return StatusBarHelper(
      key: key,
      style: style ?? this.style,
      child: child ?? this.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: style == StatusBarStyle.light
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: child,
    );
  }
}
