import 'package:flutter/widgets.dart';

import 'configuration.dart';
import 'match.dart';
import 'misc/error_screen.dart';
import 'navigator.dart';
import 'page.dart';
import 'pages/custom_transition_page.dart';
import 'typedefs.dart';

/// Signature for a function that takes in a `route` to be popped with
/// the `result` and returns a boolean decision on whether the pop
/// is successful.
///
/// The `match` is the corresponding [RouteMatch] the `route`
/// associates with.
///
/// Used by of [RouteBuilder.onPopPageWithRouteMatch].
typedef PopPageWithRouteMatchCallback = bool Function(
    Route<dynamic> route, dynamic result, RouteMatch? match);

/// Builds the top-level Navigator for ZeroRouter.
class RouteBuilder {
  /// [RouteBuilder] constructor.
  RouteBuilder({
    required this.configuration,
    required this.builderWithNav,
    required this.errorPageBuilder,
    required this.errorBuilder,
    required this.restorationScopeId,
    required this.observers,
    required this.onPopPageWithRouteMatch,
  });

  /// Builder function for a zero router with Navigator.
  final ZeroRouterBuilderWithNav builderWithNav;

  /// Error page builder for the zero router delegate.
  final ZeroRouterPageBuilder? errorPageBuilder;

  /// Error widget builder for the zero router delegate.
  final ZeroRouterWidgetBuilder? errorBuilder;

  /// The route configuration for the app.
  final RouteConfiguration configuration;

  /// Restoration ID to save and restore the state of the navigator, including
  /// its history.
  final String? restorationScopeId;

  /// NavigatorObserver used to receive notifications when navigating in between routes.
  /// changes.
  final List<NavigatorObserver> observers;

  final ZeroRouterStateRegistry _registry = ZeroRouterStateRegistry();

  /// A callback called when a `route` produced by `match` is about to be popped
  /// with the `result`.
  ///
  /// If this method returns true, this builder pops the `route` and `match`.
  ///
  /// If this method returns false, this builder aborts the pop.
  final PopPageWithRouteMatchCallback onPopPageWithRouteMatch;

  /// Caches a HeroController for the nested Navigator, which solves cases where the
  /// Hero Widget animation stops working when navigating.

  /// Builds the top-level Navigator for the given [RouteMatchList].
  Widget build(
    BuildContext context,
    RouteMatchList matchList,
    bool routerNeglect,
  ) {
    if (matchList.isEmpty && !matchList.isError) {
      // The build method can be called before async redirect finishes. Build a
      // empty box until then.
      return const SizedBox.shrink();
    }
    return builderWithNav(
      context,
      Builder(
        builder: (BuildContext context) {
          final Map<Page<Object?>, ZeroRouterState> newRegistry =
              <Page<Object?>, ZeroRouterState>{};
          final Widget result = tryBuild(context, matchList, routerNeglect,
              configuration.navigatorKey, newRegistry);
          _registry.updateRegistry(newRegistry);
          return ZeroRouterStateRegistryScope(
              registry: _registry, child: result);
        },
      ),
    );
  }

  /// Builds the top-level Navigator by invoking the build method on each
  /// matching route.
  ///
  /// Throws a [_RouteBuilderError].
  @visibleForTesting
  Widget tryBuild(
    BuildContext context,
    RouteMatchList matchList,
    bool routerNeglect,
    GlobalKey<NavigatorState> navigatorKey,
    Map<Page<Object?>, ZeroRouterState> registry,
  ) {
    final _PagePopContext pagePopContext =
        _PagePopContext._(onPopPageWithRouteMatch);
    return builderWithNav(
      context,
      _buildNavigator(
        pagePopContext.onPopPage,
        matchList.routes,
        navigatorKey,
        observers: observers,
        restorationScopeId: restorationScopeId,
      ),
    );
  }

  static Widget _buildNavigator(
    PopPageCallback onPopPage,
    List<ZeroPage> pages,
    Key? navigatorKey, {
    List<NavigatorObserver> observers = const <NavigatorObserver>[],
    String? restorationScopeId,
    HeroController? heroController,
  }) {
    final Widget navigator = ZeroNavigator(
      key: navigatorKey,
      pages: pages,
    );
    if (heroController != null) {
      return HeroControllerScope(
        controller: heroController,
        child: navigator,
      );
    } else {
      return navigator;
    }
  }

  /// Helper method that builds a [ZeroRouterState] object for the given [match]
  /// and [pathParameters].
  @visibleForTesting
  ZeroRouterState buildState(RouteMatchList matchList, RouteMatch match) {
    final ZeroPage route = match.route;
    String? name;
    String path = '';
    name = route.id;
    path = route.path;
    final RouteMatchList effectiveMatchList;
    if (match is ImperativeRouteMatch) {
      effectiveMatchList = match.matches;
      if (effectiveMatchList.isError) {
        return _buildErrorState(effectiveMatchList);
      }
    } else {
      effectiveMatchList = matchList;
      assert(!effectiveMatchList.isError);
    }
    return ZeroRouterState(
      configuration,
      location: effectiveMatchList.uri.toString(),
      matchedLocation: match.matchedLocation,
      name: name,
      path: path,
      fullPath: effectiveMatchList.fullPath,
      pathParameters:
          Map<String, String>.from(effectiveMatchList.pathParameters),
      error: effectiveMatchList.error,
      queryParameters: effectiveMatchList.uri.queryParameters,
      queryParametersAll: effectiveMatchList.uri.queryParametersAll,
      extra: effectiveMatchList.extra,
      pageKey: match.pageKey,
    );
  }

  _PageBuilderForAppType? _pageBuilderForAppType;

  Widget Function(
    BuildContext context,
    ZeroRouterState state,
  )? _errorBuilderForAppType;

  void _cacheAppType(BuildContext context) {
    // cache app type-specific page and error builders
    if (_pageBuilderForAppType == null) {
      assert(_errorBuilderForAppType == null);

      _pageBuilderForAppType = pageBuilderForWidgetApp;
      _errorBuilderForAppType =
          (BuildContext c, ZeroRouterState s) => ErrorScreen(s.error);
    }

    assert(_pageBuilderForAppType != null);
    assert(_errorBuilderForAppType != null);
  }

  /// builds the page based on app type, i.e. MaterialApp vs. CupertinoApp
  @visibleForTesting
  Page<Object?> buildPage(
    BuildContext context,
    ZeroRouterState state,
    Widget child,
  ) {
    // build the page based on app type
    _cacheAppType(context);
    return _pageBuilderForAppType!(
      key: state.pageKey,
      name: state.name ?? state.path,
      arguments: <String, String>{
        ...state.pathParameters,
        ...state.queryParameters
      },
      restorationId: state.pageKey.value,
      child: child,
    );
  }

  /// Builds a page without any transitions.
  Page<void> pageBuilderForWidgetApp({
    required LocalKey key,
    required String? name,
    required Object? arguments,
    required String restorationId,
    required Widget child,
  }) =>
      NoTransitionPage<void>(
        name: name,
        arguments: arguments,
        key: key,
        restorationId: restorationId,
        child: child,
      );

  ZeroRouterState _buildErrorState(RouteMatchList matchList) {
    final String location = matchList.uri.toString();
    assert(matchList.isError);
    return ZeroRouterState(
      configuration,
      location: location,
      matchedLocation: matchList.uri.path,
      fullPath: matchList.fullPath,
      pathParameters: matchList.pathParameters,
      queryParameters: matchList.uri.queryParameters,
      queryParametersAll: matchList.uri.queryParametersAll,
      error: matchList.error,
      pageKey: ValueKey<String>('$location(error)'),
    );
  }

  /// Builds a an error page.
  Page<void> _buildErrorPage(BuildContext context, ZeroRouterState state) {
    assert(state.error != null);

    // If the error page builder is provided, use that, otherwise, if the error
    // builder is provided, wrap that in an app-specific page (for example,
    // MaterialPage). Finally, if nothing is provided, use a default error page
    // wrapped in the app-specific page.
    _cacheAppType(context);
    final ZeroRouterWidgetBuilder? errorBuilder = this.errorBuilder;
    return errorPageBuilder != null
        ? errorPageBuilder!(context, state)
        : buildPage(
            context,
            state,
            errorBuilder != null
                ? errorBuilder(context)
                : _errorBuilderForAppType!(context, state),
          );
  }
}

typedef _PageBuilderForAppType = Page<void> Function({
  required LocalKey key,
  required String? name,
  required Object? arguments,
  required String restorationId,
  required Widget child,
});

/// Context used to provide a route to page association when popping routes.
class _PagePopContext {
  _PagePopContext._(this.onPopPageWithRouteMatch);

  final Map<Page<dynamic>, RouteMatch> _routeMatchLookUp =
      <Page<Object?>, RouteMatch>{};

  /// On pop page callback that includes the associated [RouteMatch].
  final PopPageWithRouteMatchCallback onPopPageWithRouteMatch;

  /// Looks for the [RouteMatch] for a given [Page].
  ///
  /// The [Page] must have been previously built via the [RouteBuilder] that
  /// created this [PagePopContext]; otherwise, this method returns null.
  RouteMatch? getRouteMatchForPage(Page<Object?> page) =>
      _routeMatchLookUp[page];

  void _setRouteMatchForPage(Page<Object?> page, RouteMatch match) =>
      _routeMatchLookUp[page] = match;

  /// Function used as [Navigator.onPopPage] callback when creating Navigators.
  ///
  /// This function forwards to [onPopPageWithRouteMatch], including the
  /// [RouteMatch] associated with the popped route.
  bool onPopPage(Route<dynamic> route, dynamic result) {
    final Page<Object?> page = route.settings as Page<Object?>;
    return onPopPageWithRouteMatch(route, result, _routeMatchLookUp[page]);
  }
}
