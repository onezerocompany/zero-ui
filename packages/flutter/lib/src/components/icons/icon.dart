import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;

class Icon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double size;

  const Icon({
    super.key,
    required this.icon,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? Theme.of(context).colorScheme.onSurface;
    return SizedBox.square(
      dimension: size,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -size * 0.09,
            child: material.Icon(
              icon,
              key: ValueKey(icon),
              color: color,
              size: size,
              opticalSize: size,
              grade: 0,
              weight: 300,
            ),
          ),
        ],
      ),
    );
  }
}
