import 'dart:async' show FutureOr;

import 'package:flutter/widgets.dart';

import 'configuration.dart';

/// The widget builder for [ZeroPage].
typedef ZeroRouterWidgetBuilder = Widget Function(
  BuildContext context,
);

/// The page builder for [ZeroPage].
typedef ZeroRouterPageBuilder = Page<dynamic> Function(
  BuildContext context,
  ZeroRouterState state,
);

/// The widget builder for [ShellRoute].
typedef ShellRouteBuilder = Widget Function(
  BuildContext context,
  ZeroRouterState state,
  Widget child,
);

/// The page builder for [ShellRoute].
typedef ShellRoutePageBuilder = Page<dynamic> Function(
  BuildContext context,
  ZeroRouterState state,
  Widget child,
);

/// Signature of a zero router builder function with navigator.
typedef ZeroRouterBuilderWithNav = Widget Function(
  BuildContext context,
  Widget child,
);

/// The signature of the redirect callback.
typedef ZeroRouterRedirect = FutureOr<String?> Function(
    BuildContext context, ZeroRouterState state);

/// Signature for functions used to build Navigators
typedef NavigatorBuilder = Widget Function(
    List<NavigatorObserver>? observers, String? restorationScopeId);
