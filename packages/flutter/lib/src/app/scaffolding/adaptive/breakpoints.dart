export 'adaptive_context.dart';
export 'adaptive_value.dart';

enum BreakPoint {
  xxs,
  xs,
  sm,
  md,
  lg,
  xl,
  xxl,
}

class BreakPoints {
  final Map<BreakPoint, double> points;

  BreakPoint breakpoint(double width) {
    BreakPoint? breakpoint;
    points.forEach((key, value) {
      if (width >= value) {
        breakpoint = key;
      }
    });
    return breakpoint ?? BreakPoint.xs;
  }

  const BreakPoints({
    this.points = const {
      BreakPoint.xxs: 0,
      BreakPoint.xs: 360,
      BreakPoint.sm: 600,
      BreakPoint.md: 960,
      BreakPoint.lg: 1280,
      BreakPoint.xl: 1640,
      BreakPoint.xxl: 1920,
    },
  });
}
