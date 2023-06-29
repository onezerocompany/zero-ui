import 'package:flutter/widgets.dart';

import 'configuration.dart';
import 'misc/errors.dart';

/// The route state during routing.
///
/// The state contains parsed artifacts of the current URI.
@immutable
class ZeroRouterState {
  /// Default constructor for creating route state during routing.
  const ZeroRouterState(
    this._configuration, {
    required this.location,
    required this.matchedLocation,
    this.name,
    this.path,
    required this.fullPath,
    required this.pathParameters,
    required this.queryParameters,
    required this.queryParametersAll,
    this.extra,
    this.error,
    required this.pageKey,
  });
  final RouteConfiguration _configuration;

  /// The full location of the route, e.g. /family/f2/person/p1
  final String location;

  /// The matched location until this point.
  ///
  /// For example:
  ///
  /// location = /family/f2/person/p1
  /// route = ZeroRoute('/family/:id')
  ///
  /// matchedLocation = /family/f2
  final String matchedLocation;

  /// The optional name of the route associated with this app.
  ///
  /// This can be null for ZeroRouterState pass into top level redirect.
  final String? name;

  /// The path of the route associated with this app. e.g. family/:fid
  ///
  /// This can be null for ZeroRouterState pass into top level redirect.
  final String? path;

  /// The full path to this sub-route, e.g. /family/:fid
  ///
  /// For top level redirect, this is the entire path that matches the location.
  /// It can be empty if zero router can't find a match. In that case, the [error]
  /// contains more information.
  final String? fullPath;

  /// The parameters for this match, e.g. {'fid': 'f2'}
  final Map<String, String> pathParameters;

  /// The query parameters for the location, e.g. {'from': '/family/f2'}
  final Map<String, String> queryParameters;

  /// The query parameters for the location,
  /// e.g. `{'q1': ['v1'], 'q2': ['v2', 'v3']}`
  final Map<String, List<String>> queryParametersAll;

  /// An extra object to pass along with the navigation.
  final Object? extra;

  /// The error associated with this sub-route.
  final ZeroException? error;

  /// A unique string key for this sub-route.
  /// E.g.
  /// ```dart
  /// ValueKey('/family/:fid')
  /// ```
  final ValueKey<String> pageKey;

  /// Gets the [ZeroRouterState] from context.
  ///
  /// The returned [ZeroRouterState] will depends on which [ZeroPage] or
  /// [ShellRoute] the input `context` is in.
  ///
  /// This method only supports [ZeroPage] and [ShellRoute] that generate
  /// [ModalRoute]s. This is typically the case if one uses [ZeroPage.build],
  /// [ShellRoute.builder], [CupertinoPage], [MaterialPage],
  /// [CustomTransitionPage], or [NoTransitionPage].
  ///
  /// This method is fine to be called during [ZeroPage.build] or
  /// [ShellRoute.builder].
  ///
  /// This method cannot be called during [ZeroPage.pageBuilder] or
  /// [ShellRoute.pageBuilder] since there is no [ZeroRouterState] to be
  /// associated with.
  ///
  /// To access ZeroRouterState from a widget.
  ///
  /// ```
  /// ZeroRoute(
  ///   path: '/:id'
  ///   builder: (_, __) => MyWidget(),
  /// );
  ///
  /// class MyWidget extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Text('${ZeroRouterState.of(context).pathParameters['id']}');
  ///   }
  /// }
  /// ```
  static ZeroRouterState of(BuildContext context) {
    final ModalRoute<Object?>? route = ModalRoute.of(context);
    if (route == null) {
      throw ZeroError('There is no modal route above the current context.');
    }
    final RouteSettings settings = route.settings;
    if (settings is! Page<Object?>) {
      throw ZeroError(
          'The parent route must be a page route to have a ZeroRouterState');
    }
    final ZeroRouterStateRegistryScope? scope = context
        .dependOnInheritedWidgetOfExactType<ZeroRouterStateRegistryScope>();
    if (scope == null) {
      throw ZeroError(
          'There is no ZeroRouterStateRegistryScope above the current context.');
    }
    final ZeroRouterState state =
        scope.notifier!._createPageRouteAssociation(settings, route);
    return state;
  }

  /// Get a location from route name and parameters.
  /// This is useful for redirecting to a named location.
  String namedLocation(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
  }) {
    return _configuration.namedLocation(name,
        pathParameters: pathParameters, queryParameters: queryParameters);
  }

  @override
  bool operator ==(Object other) {
    return other is ZeroRouterState &&
        other.location == location &&
        other.matchedLocation == matchedLocation &&
        other.name == name &&
        other.path == path &&
        other.fullPath == fullPath &&
        other.pathParameters == pathParameters &&
        other.queryParameters == queryParameters &&
        other.queryParametersAll == queryParametersAll &&
        other.extra == extra &&
        other.error == error &&
        other.pageKey == pageKey;
  }

  @override
  int get hashCode => Object.hash(
      location,
      matchedLocation,
      name,
      path,
      fullPath,
      pathParameters,
      queryParameters,
      queryParametersAll,
      extra,
      error,
      pageKey);
}

/// An inherited widget to host a [ZeroRouterStateRegistry] for the subtree.
///
/// Should not be used directly, consider using [ZeroRouterState.of] to access
/// [ZeroRouterState] from the context.
class ZeroRouterStateRegistryScope
    extends InheritedNotifier<ZeroRouterStateRegistry> {
  /// Creates a ZeroRouterStateRegistryScope.
  const ZeroRouterStateRegistryScope({
    super.key,
    required ZeroRouterStateRegistry registry,
    required super.child,
  }) : super(notifier: registry);
}

/// A registry to record [ZeroRouterState] to [Page] relation.
///
/// Should not be used directly, consider using [ZeroRouterState.of] to access
/// [ZeroRouterState] from the context.
class ZeroRouterStateRegistry extends ChangeNotifier {
  /// creates a [ZeroRouterStateRegistry].
  ZeroRouterStateRegistry();

  /// A [Map] that maps a [Page] to a [ZeroRouterState].
  @visibleForTesting
  final Map<Page<Object?>, ZeroRouterState> registry =
      <Page<Object?>, ZeroRouterState>{};

  final Map<Route<Object?>, Page<Object?>> _routePageAssociation =
      <ModalRoute<Object?>, Page<Object?>>{};

  ZeroRouterState _createPageRouteAssociation(
      Page<Object?> page, ModalRoute<Object?> route) {
    assert(route.settings == page);
    assert(registry.containsKey(page));
    final Page<Object?>? oldPage = _routePageAssociation[route];
    if (oldPage == null) {
      // This is a new association.
      _routePageAssociation[route] = page;
      // If there is an association, the registry relies on the route to remove
      // entry from registry because it wants to preserve the ZeroRouterState
      // until the route finishes the popping animations.
      route.completed.then<void>((Object? result) {
        // Can't use `page` directly because Route.settings may have changed during
        // the lifetime of this route.
        final Page<Object?> associatedPage =
            _routePageAssociation.remove(route)!;
        assert(registry.containsKey(associatedPage));
        registry.remove(associatedPage);
      });
    } else if (oldPage != page) {
      // Need to update the association to avoid memory leak.
      _routePageAssociation[route] = page;
      assert(registry.containsKey(oldPage));
      registry.remove(oldPage);
    }
    assert(_routePageAssociation[route] == page);
    return registry[page]!;
  }

  /// Updates this registry with new records.
  void updateRegistry(Map<Page<Object?>, ZeroRouterState> newRegistry) {
    bool shouldNotify = false;
    final Set<Page<Object?>> pagesWithAssociation =
        _routePageAssociation.values.toSet();
    for (final MapEntry<Page<Object?>, ZeroRouterState> entry
        in newRegistry.entries) {
      final ZeroRouterState? existingState = registry[entry.key];
      if (existingState != null) {
        if (existingState != entry.value) {
          shouldNotify =
              shouldNotify || pagesWithAssociation.contains(entry.key);
          registry[entry.key] = entry.value;
        }
        continue;
      }
      // Not in the _registry.
      registry[entry.key] = entry.value;
      // Adding or removing registry does not need to notify the listen since
      // no one should be depending on them.
    }
    registry.removeWhere((Page<Object?> key, ZeroRouterState value) {
      if (newRegistry.containsKey(key)) {
        return false;
      }
      // For those that have page route association, it will be removed by the
      // route future. Need to notify the listener so they can update the page
      // route association if its page has changed.
      if (pagesWithAssociation.contains(key)) {
        shouldNotify = true;
        return false;
      }
      return true;
    });
    if (shouldNotify) {
      notifyListeners();
    }
  }
}
