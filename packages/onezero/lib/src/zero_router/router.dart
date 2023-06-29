import 'package:flutter/widgets.dart';
import 'package:onezero/src/zero_router/page.dart';

import 'configuration.dart';
import 'delegate.dart';
import 'information_provider.dart';
import 'logging.dart';
import 'match.dart';
import 'misc/inherited_router.dart';
import 'parser.dart';
import 'typedefs.dart';

/// The function signature of [ZeroRouter.onException].
///
/// Use `state.error` to access the exception.
typedef ZeroRouterExceptionHandler = void Function(
  BuildContext context,
  ZeroRouterState state,
  ZeroRouter router,
);

/// The route configuration for the app.
///
/// The `routes` list specifies the top-level routes for the app. It must not be
/// empty and must contain an [ZeroRouter] to match `/`.
///
/// The [redirect] callback allows the app to redirect to a new location.
/// Alternatively, you can specify a redirect for an individual route using
/// [ZeroPage.redirect]. If [BuildContext.dependOnInheritedWidgetOfExactType] is
/// used during the redirection (which is how `of` methods are usually
/// implemented), a re-evaluation will be triggered when the [InheritedWidget]
/// changes.
///
/// To handle exceptions, use one of `onException`, `errorBuilder`, or
/// `errorPageBuilder`. The `onException` is called when an exception is thrown.
/// If `onException` is not provided, the exception is passed to
/// `errorPageBuilder` to build a page for the Router if it is not null;
/// otherwise, it is passed to `errorBuilder` instead. If none of them are
/// provided, zero_router builds a default error screen to show the exception.
/// for more details.
///
/// See also:
/// * [ZeroPage], which provides APIs to define the routing table.
/// {@category Get started}
/// {@category Upgrading}
/// {@category Configuration}
/// {@category Navigation}
/// {@category Redirection}
/// {@category Web}
/// {@category Deep linking}
/// {@category Error handling}
/// {@category Named routes}
class ZeroRouter implements RouterConfig<RouteMatchList> {
  /// Default constructor to configure a ZeroRouter with a routes builder
  /// and an error page builder.
  ///
  /// The `routes` must not be null and must contain an [ZeroRouter] to match `/`.
  ZeroRouter({
    required List<ZeroPage> pages,
    ZeroRouterExceptionHandler? onException,
    ZeroRouterPageBuilder? errorPageBuilder,
    ZeroRouterWidgetBuilder? errorBuilder,
    ZeroRouterRedirect? redirect,
    Listenable? refreshListenable,
    int redirectLimit = 5,
    bool routerNeglect = false,
    String? initialLocation,
    Object? initialExtra,
    List<NavigatorObserver>? observers,
    bool debugLogDiagnostics = false,
    GlobalKey<NavigatorState>? navigatorKey,
    String? restorationScopeId,
  })  : backButtonDispatcher = RootBackButtonDispatcher(),
        assert(
          initialExtra == null || initialLocation != null,
          'initialLocation must be set in order to use initialExtra',
        ),
        assert(
            (onException == null ? 0 : 1) +
                    (errorPageBuilder == null ? 0 : 1) +
                    (errorBuilder == null ? 0 : 1) <
                2,
            'Only one of onException, errorPageBuilder, or errorBuilder can be provided.'),
        assert(_debugCheckPath(pages, true)),
        assert(_debugCheckParentNavigatorKeys(
            pages,
            navigatorKey == null
                ? <GlobalKey<NavigatorState>>[]
                : <GlobalKey<NavigatorState>>[navigatorKey])) {
    setLogging(enabled: debugLogDiagnostics);
    WidgetsFlutterBinding.ensureInitialized();

    navigatorKey ??= GlobalKey<NavigatorState>();

    configuration = RouteConfiguration(
      pages: pages,
      topRedirect: redirect ?? (_, __) => null,
      redirectLimit: redirectLimit,
      navigatorKey: navigatorKey,
    );

    final ParserExceptionHandler? parserExceptionHandler;
    if (onException != null) {
      parserExceptionHandler =
          (BuildContext context, RouteMatchList routeMatchList) {
        onException(context,
            configuration.buildTopLevelZeroRouterState(routeMatchList), this);
        // Avoid updating ZeroRouterDelegate if onException is provided.
        return routerDelegate.currentConfiguration;
      };
    } else {
      parserExceptionHandler = null;
    }

    routeInformationParser = ZeroRouteInformationParser(
      onParserException: parserExceptionHandler,
      configuration: configuration,
    );

    routeInformationProvider = ZeroRouteInformationProvider(
      initialLocation: _effectiveInitialLocation(initialLocation),
      initialExtra: initialExtra,
      refreshListenable: refreshListenable,
    );

    routerDelegate = ZeroRouterDelegate(
      configuration: configuration,
      onException: onException,
      errorPageBuilder: errorPageBuilder,
      errorBuilder: errorBuilder,
      routerNeglect: routerNeglect,
      observers: <NavigatorObserver>[
        ...observers ?? <NavigatorObserver>[],
      ],
      restorationScopeId: restorationScopeId,
      // wrap the returned Navigator to enable ZeroRouter.of(context).go() et al,
      // allowing the caller to wrap the navigator themselves
      builderWithNav: (BuildContext context, Widget child) =>
          InheritedZeroRouter(zeroRouter: this, child: child),
    );

    assert(() {
      log.info('setting initial location $initialLocation');
      return true;
    }());
  }

  static bool _debugCheckPath(List<ZeroPage> routes, bool isTopLevel) {
    for (final ZeroPage route in routes) {
      late bool subRouteIsTopLevel;
      if (isTopLevel) {
        assert(route.path.startsWith('/'),
            'top-level path must start with "/": $route');
      } else {
        assert(!route.path.startsWith('/') && !route.path.endsWith('/'),
            'sub-route path may not start or end with /: $route');
      }
      subRouteIsTopLevel = false;
      _debugCheckPath(route.children, subRouteIsTopLevel);
    }
    return true;
  }

  // Check that each parentNavigatorKey refers to either a ShellRoute's
  // navigatorKey or the root navigator key.
  static bool _debugCheckParentNavigatorKeys(
    List<ZeroPage> pages,
    List<GlobalKey<NavigatorState>> allowedKeys,
  ) {
    for (final ZeroPage page in pages) {
      final GlobalKey<NavigatorState>? parentKey = page.parentNavigatorKey;
      if (parentKey != null) {
        // Verify that the root navigator or a ShellRoute ancestor has a
        // matching navigator key.
        assert(
            allowedKeys.contains(parentKey),
            'parentNavigatorKey $parentKey must refer to'
            " an ancestor ShellRoute's navigatorKey or ZeroRouter's"
            ' navigatorKey');

        _debugCheckParentNavigatorKeys(
          page.children,
          <GlobalKey<NavigatorState>>[
            // Once a parentNavigatorKey is used, only that navigator key
            // or keys above it can be used.
            ...allowedKeys.sublist(0, allowedKeys.indexOf(parentKey) + 1),
          ],
        );
      } else {
        _debugCheckParentNavigatorKeys(
          page.children,
          <GlobalKey<NavigatorState>>[
            ...allowedKeys,
          ],
        );
      }
    }
    return true;
  }

  /// Whether the imperative API affects browser URL bar.
  ///
  /// The Imperative APIs refer to [push], [pushReplacement], or [Replace].
  ///
  /// If this option is set to true. The URL bar reflects the top-most [ZeroPage]
  /// regardless the [RouteBase]s underneath.
  ///
  /// If this option is set to false. The URL bar reflects the [RouteBase]s
  /// in the current state but ignores any [RouteBase]s that are results of
  /// imperative API calls.
  ///
  /// Defaults to false.
  ///
  /// This option is for backward compatibility. It is strongly suggested
  /// against setting this value to true, as the URL of the top-most [ZeroPage]
  /// is not always deeplink-able.
  ///
  /// This option only affects web platform.
  static bool optionURLReflectsImperativeAPIs = false;

  /// The route configuration used in zero_router.
  late final RouteConfiguration configuration;

  @override
  final BackButtonDispatcher backButtonDispatcher;

  /// The router delegate. Provide this to the MaterialApp or CupertinoApp's
  /// `.router()` constructor
  @override
  late final ZeroRouterDelegate routerDelegate;

  /// The route information provider used by [ZeroRouter].
  @override
  late final ZeroRouteInformationProvider routeInformationProvider;

  /// The route information parser used by [ZeroRouter].
  @override
  late final ZeroRouteInformationParser routeInformationParser;

  /// Returns `true` if there is at least two or more route can be pop.
  bool canPop() => routerDelegate.canPop();

  /// Get a location from route name and parameters.
  /// This is useful for redirecting to a named location.
  String namedLocation(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) =>
      configuration.namedLocation(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );

  /// Navigate to a URI location w/ optional query parameters, e.g.
  /// `/family/f2/person/p1?color=blue`
  void go(String location, {Object? extra}) {
    log.info('going to $location');
    routeInformationProvider.go(location, extra: extra);
  }

  /// Restore the RouteMatchList
  void restore(RouteMatchList matchList) {
    log.info('going to ${matchList.uri}');
    routeInformationProvider.restore(
      matchList.uri.toString(),
      encodedMatchList: RouteMatchListCodec(configuration).encode(matchList),
    );
  }

  /// Navigate to a named route w/ optional parameters, e.g.
  /// `name='person', pathParameters={'fid': 'f2', 'pid': 'p1'}`
  /// Navigate to the named route.
  void goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      go(
        namedLocation(name,
            pathParameters: pathParameters, queryParameters: queryParameters),
        extra: extra,
      );

  /// Push a URI location onto the page stack w/ optional query parameters, e.g.
  /// `/family/f2/person/p1?color=blue`.
  ///
  /// See also:
  /// * [pushReplacement] which replaces the top-most page of the page stack and
  ///   always use a new page key.
  /// * [replace] which replaces the top-most page of the page stack but treats
  ///   it as the same page. The page key will be reused. This will preserve the
  ///   state and not run any page animation.
  Future<T?> push<T extends Object?>(String location, {Object? extra}) async {
    log.info('pushing $location');
    return routeInformationProvider.push<T>(
      location,
      base: routerDelegate.currentConfiguration,
      extra: extra,
    );
  }

  /// Push a named route onto the page stack w/ optional parameters, e.g.
  /// `name='person', pathParameters={'fid': 'f2', 'pid': 'p1'}`
  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      push<T>(
        namedLocation(name,
            pathParameters: pathParameters, queryParameters: queryParameters),
        extra: extra,
      );

  /// Replaces the top-most page of the page stack with the given URL location
  /// w/ optional query parameters, e.g. `/family/f2/person/p1?color=blue`.
  ///
  /// See also:
  /// * [go] which navigates to the location.
  /// * [push] which pushes the given location onto the page stack.
  /// * [replace] which replaces the top-most page of the page stack but treats
  ///   it as the same page. The page key will be reused. This will preserve the
  ///   state and not run any page animation.
  Future<T?> pushReplacement<T extends Object?>(String location,
      {Object? extra}) {
    log.info('pushReplacement $location');
    return routeInformationProvider.pushReplacement<T>(
      location,
      base: routerDelegate.currentConfiguration,
      extra: extra,
    );
  }

  /// Replaces the top-most page of the page stack with the named route w/
  /// optional parameters, e.g. `name='person', pathParameters={'fid': 'f2', 'pid':
  /// 'p1'}`.
  ///
  /// See also:
  /// * [goNamed] which navigates a named route.
  /// * [pushNamed] which pushes a named route onto the page stack.
  Future<T?> pushReplacementNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return pushReplacement<T>(
      namedLocation(name,
          pathParameters: pathParameters, queryParameters: queryParameters),
      extra: extra,
    );
  }

  /// Replaces the top-most page of the page stack with the given one but treats
  /// it as the same page.
  ///
  /// The page key will be reused. This will preserve the state and not run any
  /// page animation.
  ///
  /// See also:
  /// * [push] which pushes the given location onto the page stack.
  /// * [pushReplacement] which replaces the top-most page of the page stack but
  ///   always uses a new page key.
  Future<T?> replace<T>(String location, {Object? extra}) {
    log.info('replace $location');
    return routeInformationProvider.replace<T>(
      location,
      base: routerDelegate.currentConfiguration,
      extra: extra,
    );
  }

  /// Replaces the top-most page with the named route and optional parameters,
  /// preserving the page key.
  ///
  /// This will preserve the state and not run any page animation. Optional
  /// parameters can be providded to the named route, e.g. `name='person',
  /// pathParameters={'fid': 'f2', 'pid': 'p1'}`.
  ///
  /// See also:
  /// * [pushNamed] which pushes the given location onto the page stack.
  /// * [pushReplacementNamed] which replaces the top-most page of the page
  ///   stack but always uses a new page key.
  Future<T?> replaceNamed<T>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return replace(
      namedLocation(name,
          pathParameters: pathParameters, queryParameters: queryParameters),
      extra: extra,
    );
  }

  /// Pop the top-most route off the current screen.
  ///
  /// If the top-most route is a pop up or dialog, this method pops it instead
  /// of any ZeroRoute under it.
  void pop<T extends Object?>([T? result]) {
    assert(() {
      log.info('popping ${routerDelegate.currentConfiguration.uri}');
      return true;
    }());
    routerDelegate.pop<T>(result);
  }

  /// Refresh the route.
  void refresh() {
    assert(() {
      log.info('refreshing ${routerDelegate.currentConfiguration.uri}');
      return true;
    }());
    routeInformationProvider.notifyListeners();
  }

  /// Find the current ZeroRouter in the widget tree.
  ///
  /// This method throws when it is called during redirects.
  static ZeroRouter of(BuildContext context) {
    final ZeroRouter? inherited = maybeOf(context);
    assert(inherited != null, 'No ZeroRouter found in context');
    return inherited!;
  }

  /// The current ZeroRouter in the widget tree, if any.
  ///
  /// This method returns null when it is called during redirects.
  static ZeroRouter? maybeOf(BuildContext context) {
    final InheritedZeroRouter? inherited = context
        .getElementForInheritedWidgetOfExactType<InheritedZeroRouter>()
        ?.widget as InheritedZeroRouter?;
    return inherited?.zeroRouter;
  }

  /// Disposes resource created by this object.
  void dispose() {
    routeInformationProvider.dispose();
    routerDelegate.dispose();
  }

  String _effectiveInitialLocation(String? initialLocation) {
    final String platformDefault =
        WidgetsBinding.instance.platformDispatcher.defaultRouteName;
    if (initialLocation == null) {
      return platformDefault;
    } else if (platformDefault == '/') {
      return initialLocation;
    } else {
      return platformDefault;
    }
  }
}
