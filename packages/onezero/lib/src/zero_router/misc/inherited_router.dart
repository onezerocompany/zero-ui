import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../router.dart';

/// ZeroRouter implementation of InheritedWidget.
///
/// Used for to find the current ZeroRouter in the widget tree. This is useful
/// when routing from anywhere in your app.
class InheritedZeroRouter extends InheritedWidget {
  /// Default constructor for the inherited zero router.
  const InheritedZeroRouter({
    required super.child,
    required this.zeroRouter,
    super.key,
  });

  /// The [ZeroRouter] that is made available to the widget tree.
  final ZeroRouter zeroRouter;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ZeroRouter>('zeroRouter', zeroRouter));
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
