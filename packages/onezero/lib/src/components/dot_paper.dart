import 'package:onezero/onezero.dart';

class DotPaper extends StatelessWidget {
  final double dotRadius;
  final double dotSpacing;
  final DynamicColor color;

  const DotPaper({
    Key? key,
    required this.dotSpacing,
    required this.dotRadius,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DotPaperPainter(
        context: context,
        dotSpacing: dotSpacing,
        dotRadius: dotRadius,
        color: color,
      ),
    );
  }
}

class _DotPaperPainter extends CustomPainter {
  final BuildContext context;
  final double dotSpacing;
  final double dotRadius;
  final DynamicColor color;

  _DotPaperPainter({
    required this.context,
    required this.dotSpacing,
    required this.dotRadius,
    required this.color,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final colors = ZeroTheme.of(context).colors;
    final paint = Paint()
      ..color = colors.card.divider.resolve(context)
      ..strokeWidth = 2;

    for (var x = -dotSpacing; x < size.width + dotSpacing; x += dotSpacing) {
      for (var y = 0.0; y < size.height + dotSpacing; y += dotSpacing) {
        canvas.drawCircle(
          Offset(
            x + dotRadius,
            y + dotRadius,
          ),
          dotRadius,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_DotPaperPainter oldDelegate) {
    return oldDelegate.dotSpacing != dotSpacing;
  }
}
