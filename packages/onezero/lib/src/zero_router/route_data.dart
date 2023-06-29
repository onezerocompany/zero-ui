// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

import 'page.dart';
import 'state.dart';

/// A superclass for each route data
abstract class RouteData {
  /// Default const constructor
  const RouteData();
}

/// Baseclass for supporting
/// [Type-safe routing](https://pub.dev/documentation/go_router/latest/topics/Type-safe%20routes-topic.html).
///
/// Subclasses must override one of [build], [buildPage], or
/// [redirect].
/// {@category Type-safe routes}
abstract class ZeroRouteData extends RouteData {
  /// Allows subclasses to have `const` constructors.
  ///
  /// [ZeroRouteData] is abstract and cannot be instantiated directly.
  const ZeroRouteData();

  /// Creates the [Widget] for `this` route.
  ///
  /// Subclasses must override one of [build], [buildPage], or
  /// [redirect].
  ///
  /// Corresponds to [ZeroPage.build].
  Widget build(BuildContext context) => throw UnimplementedError(
        'One of `build` or `buildPage` must be implemented.',
      );

  /// A page builder for this route.
  ///
  /// Subclasses can override this function to provide a custom [Page].
  ///
  /// Subclasses must override one of [build], [buildPage] or
  /// [redirect].
  ///
  /// Corresponds to [ZeroPage.pageBuilder].
  ///
  /// By default, returns a [Page] instance that is ignored, causing a default
  /// [Page] implementation to be used with the results of [build].
  Page<void> buildPage(BuildContext context, ZeroRouterState state) =>
      const NoOpPage();

  /// An optional redirect function for this route.
  ///
  /// Subclasses must override one of [build], [buildPage], or
  /// [redirect].
  ///
  /// Corresponds to [ZeroPage.redirect].
  FutureOr<String?> redirect(BuildContext context, ZeroRouterState state) =>
      null;

  /// A helper function used by generated code.
  ///
  /// Should not be used directly.
  static String $location(String path, {Map<String, dynamic>? queryParams}) =>
      Uri.parse(path)
          .replace(
            queryParameters:
                // Avoid `?` in generated location if `queryParams` is empty
                queryParams?.isNotEmpty ?? false ? queryParams : null,
          )
          .toString();

  /// A helper function used by generated code.
  ///
  /// Should not be used directly.
  static ZeroPage $route<T extends ZeroRouteData>({
    required String path,
    required String id,
    required String name,
    required IconData icon,
    required T Function(ZeroRouterState) factory,
    GlobalKey<NavigatorState>? parentNavigatorKey,
    List<ZeroPage> routes = const <ZeroPage>[],
  }) {
    T factoryImpl(ZeroRouterState state) {
      final Object? extra = state.extra;

      // If the "extra" value is of type `T` then we know it's the source
      // instance of `ZeroRouteData`, so it doesn't need to be recreated.
      if (extra is T) {
        return extra;
      }

      return (_stateObjectExpando[state] ??= factory(state)) as T;
    }

    FutureOr<String?> redirect(BuildContext context, ZeroRouterState state) =>
        factoryImpl(state).redirect(context, state);

    return ZeroPage(
      path: path,
      id: id,
      name: name,
      icon: icon,
      redirect: redirect,
      children: routes,
      parentNavigatorKey: parentNavigatorKey,
    );
  }

  /// Used to cache [ZeroRouteData] that corresponds to a given [ZeroRouterState]
  /// to minimize the number of times it has to be deserialized.
  static final Expando<ZeroRouteData> _stateObjectExpando =
      Expando<ZeroRouteData>(
    'ZeroRouteState to ZeroRouteData expando',
  );
}

/// Base class for supporting
/// [nested navigation](https://pub.dev/packages/go_router#nested-navigation)
abstract class ShellRouteData extends RouteData {
  /// Default const constructor
  const ShellRouteData();

  /// [pageBuilder] is used to build the page
  Page<void> pageBuilder(
    BuildContext context,
    ZeroRouterState state,
    Widget navigator,
  ) =>
      const NoOpPage();

  /// [pageBuilder] is used to build the page
  Widget builder(
    BuildContext context,
    ZeroRouterState state,
    Widget navigator,
  ) =>
      throw UnimplementedError(
        'One of `builder` or `pageBuilder` must be implemented.',
      );
}

/// A superclass for each typed route descendant
class TypedRoute<T extends RouteData> {
  /// Default const constructor
  const TypedRoute();
}

/// A superclass for each typed go route descendant
@Target(<TargetKind>{TargetKind.library, TargetKind.classType})
class TypedZeroRoute<T extends ZeroRouteData> extends TypedRoute<T> {
  /// Default const constructor
  const TypedZeroRoute({
    required this.path,
    this.name,
    this.routes = const <TypedRoute<RouteData>>[],
  });

  /// The path that corresponds to this route.
  ///
  /// See [ZeroPage.path].
  ///
  ///
  final String path;

  /// The name that corresponds to this route.
  /// Used by Analytics services such as Firebase Analytics
  /// to log the screen views in their system.
  ///
  /// See [ZeroPage.id].
  ///
  final String? name;

  /// Child route definitions.
  ///
  /// See [RouteBase.routes].
  final List<TypedRoute<RouteData>> routes;
}

/// A superclass for each typed shell route descendant
@Target(<TargetKind>{TargetKind.library, TargetKind.classType})
class TypedShellRoute<T extends ShellRouteData> extends TypedRoute<T> {
  /// Default const constructor
  const TypedShellRoute({
    this.routes = const <TypedRoute<RouteData>>[],
  });

  /// Child route definitions.
  ///
  /// See [RouteBase.routes].
  final List<TypedRoute<RouteData>> routes;
}

/// Internal class used to signal that the default page behavior should be used.
@internal
class NoOpPage extends Page<void> {
  /// Creates an instance of NoOpPage;
  const NoOpPage();

  @override
  Route<void> createRoute(BuildContext context) =>
      throw UnsupportedError('Should never be called');
}
