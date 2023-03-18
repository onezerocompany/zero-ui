import 'dart:ui';

import 'package:flutter/material.dart';

enum BlurFaderDirection {
  topToBottom,
  bottomToTop,
  leftToRight,
  rightToLeft,
}

// Simple widget that blurs the top of the screen
// the blur effect increases as to the top of the screen
class BlurFader extends StatelessWidget {
  final BlurFaderDirection direction;
  final int steps;

  const BlurFader({
    super.key,
    this.direction = BlurFaderDirection.topToBottom,
    this.steps = 6,
  });

  List<double> get blurValues {
    double step = 3.0 / steps;
    List<double> blurArray = [];
    for (double i = step; i <= 3.0; i += step) {
      blurArray.add(i);
    }
    return [BlurFaderDirection.topToBottom, BlurFaderDirection.leftToRight]
            .contains(direction)
        ? blurArray
        : blurArray.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.minHeight;
        double width = constraints.minWidth;

        return IgnorePointer(
          child: [
            BlurFaderDirection.topToBottom,
            BlurFaderDirection.bottomToTop,
          ].contains(direction)
              ? Column(
                  children: blurValues
                      .map(
                        (blurAmount) => ClipRect(
                          child: SizedBox(
                            height: height / steps,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: blurAmount,
                                sigmaY: blurAmount,
                              ),
                              child: Container(),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              : Row(
                  children: blurValues
                      .map(
                        (blurAmount) => ClipRect(
                          child: SizedBox(
                            width: width / steps,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: blurAmount,
                                sigmaY: blurAmount,
                              ),
                              child: Container(),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
        );
      },
    );
  }
}
