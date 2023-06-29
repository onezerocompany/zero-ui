import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:onezero/src/zero_router/page.dart';

import 'configuration.dart';
import 'logging.dart';
import 'match.dart';
import 'misc/errors.dart';
import 'path_utils.dart';
import 'typedefs.dart';
export 'state.dart';

/// The route configuration for ZeroRouter configured by the app.
class RouteConfiguration {
  /// Constructs a [RouteConfiguration].
  RouteConfiguration({
    required this.pages,
    required this.redirectLimit,
    required this.topRedirect,
    required this.navigatorKey,
  })  : assert(_debugCheckPath(pages, true)),
        assert(_debugCheckParentNavigatorKeys(
            pages, <GlobalKey<NavigatorState>>[navigatorKey])) {
    _cacheNameToPath('', pages);
    log.info(debugKnownRoutes());
  }

  static bool _debugCheckPath(List<ZeroPage> pages, bool isTopLevel) {
    for (final ZeroPage page in pages) {
      late bool subRouteIsTopLevel;
      if (isTopLevel) {
        if (!page.path.startsWith('/')) {
          throw ZeroError('top-level path must start with "/": $page');
        }
      } else {
        if (page.path.startsWith('/') || page.path.endsWith('/')) {
          throw ZeroError('sub-route path may not start or end with /: $page');
        }
      }
      subRouteIsTopLevel = false;
      _debugCheckPath(page.children, subRouteIsTopLevel);
    }
    return true;
  }

  // Check that each parentNavigatorKey refers to either a ShellRoute's
  // navigatorKey or the root navigator key.
  static bool _debugCheckParentNavigatorKeys(
      List<ZeroPage> pages, List<GlobalKey<NavigatorState>> allowedKeys) {
    for (final ZeroPage page in pages) {
      final GlobalKey<NavigatorState>? parentKey = page.parentNavigatorKey;
      if (parentKey != null) {
        // Verify that the root navigator or a ShellRoute ancestor has a
        // matching navigator key.
        if (!allowedKeys.contains(parentKey)) {
          throw ZeroError('parentNavigatorKey $parentKey must refer to'
              " an ancestor ShellRoute's navigatorKey or ZeroRouter's"
              ' navigatorKey');
        }

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

  /// The match used when there is an error during parsing.
  static RouteMatchList _errorRouteMatchList(Uri uri, ZeroException exception) {
    return RouteMatchList(
      matches: const <RouteMatch>[],
      error: exception,
      uri: uri,
      pathParameters: const <String, String>{},
    );
  }

  /// Builds a [ZeroRouterState] suitable for top level callback such as
  /// `ZeroRouter.redirect` or `ZeroRouter.onException`.
  ZeroRouterState buildTopLevelZeroRouterState(RouteMatchList matchList) {
    return ZeroRouterState(
      this,
      location: matchList.uri.toString(),
      // No name available at the top level trim the query params off the
      // sub-location to match route.redirect
      fullPath: matchList.fullPath,
      pathParameters: matchList.pathParameters,
      matchedLocation: matchList.uri.path,
      queryParameters: matchList.uri.queryParameters,
      queryParametersAll: matchList.uri.queryParametersAll,
      extra: matchList.extra,
      pageKey: const ValueKey<String>('topLevel'),
    );
  }

  /// The list of top level children used by [ZeroRouterDelegate].
  final List<ZeroPage> pages;

  /// The limit for the number of consecutive redirects.
  final int redirectLimit;

  /// The global key for top level navigator.
  final GlobalKey<NavigatorState> navigatorKey;

  /// Top level page redirect.
  final ZeroRouterRedirect topRedirect;

  final Map<String, String> _nameToPath = <String, String>{};

  /// Looks up the url location by a [ZeroPage]'s name.
  String namedLocation(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    assert(() {
      log.info('getting location for name: '
          '"$name"'
          '${pathParameters.isEmpty ? '' : ', pathParameters: $pathParameters'}'
          '${queryParameters.isEmpty ? '' : ', queryParameters: $queryParameters'}');
      return true;
    }());
    assert(_nameToPath.containsKey(name), 'unknown route name: $name');
    final String path = _nameToPath[name]!;
    assert(() {
      // Check that all required params are present
      final List<String> paramNames = <String>[];
      patternToRegExp(path, paramNames);
      for (final String paramName in paramNames) {
        assert(pathParameters.containsKey(paramName),
            'missing param "$paramName" for $path');
      }

      // Check that there are no extra params
      for (final String key in pathParameters.keys) {
        assert(paramNames.contains(key), 'unknown param "$key" for $path');
      }
      return true;
    }());
    final Map<String, String> encodedParams = <String, String>{
      for (final MapEntry<String, String> param in pathParameters.entries)
        param.key: Uri.encodeComponent(param.value)
    };
    final String location = patternToPath(path, encodedParams);
    return Uri(
            path: location,
            queryParameters: queryParameters.isEmpty ? null : queryParameters)
        .toString();
  }

  /// Finds the children that matched the given URL.
  RouteMatchList findMatch(String location, {Object? extra}) {
    final Uri uri = Uri.parse(canonicalUri(location));

    final Map<String, String> pathParameters = <String, String>{};
    final List<RouteMatch>? matches = _getLocRouteMatches(uri, pathParameters);

    if (matches == null) {
      return _errorRouteMatchList(
          uri, ZeroException('no routes for location: $uri'));
    }
    return RouteMatchList(
        matches: matches,
        uri: uri,
        pathParameters: pathParameters,
        extra: extra);
  }

  List<RouteMatch>? _getLocRouteMatches(
      Uri uri, Map<String, String> pathParameters) {
    final List<RouteMatch>? result = _getLocRouteRecursively(
      location: uri.path,
      remainingLocation: uri.path,
      matchedLocation: '',
      pathParameters: pathParameters,
      children: pages,
    );
    return result;
  }

  List<RouteMatch>? _getLocRouteRecursively({
    required String location,
    required String remainingLocation,
    required String matchedLocation,
    required Map<String, String> pathParameters,
    required List<ZeroPage> children,
  }) {
    List<RouteMatch>? result;
    late Map<String, String> subPathParameters;
    // find the set of matches at this level of the tree
    for (final ZeroPage route in children) {
      subPathParameters = <String, String>{};

      final RouteMatch? match = RouteMatch.match(
        route: route,
        remainingLocation: remainingLocation,
        matchedLocation: matchedLocation,
        pathParameters: subPathParameters,
      );

      if (match == null) {
        continue;
      }

      if (match.matchedLocation.toLowerCase() == location.toLowerCase()) {
        // If it is a complete match, then return the matched route
        // NOTE: need a lower case match because matchedLocation is canonicalized to match
        // the path case whereas the location can be of any case and still match
        result = <RouteMatch>[match];
      } else if (route.children.isEmpty) {
        // If it is partial match but no sub-routes, bail.
        continue;
      } else {
        // Otherwise, recurse
        final String childRestLoc;
        final String newParentSubLoc;

        assert(location.startsWith(match.matchedLocation));
        assert(remainingLocation.isNotEmpty);

        childRestLoc = location.substring(match.matchedLocation.length +
            (match.matchedLocation == '/' ? 0 : 1));
        newParentSubLoc = match.matchedLocation;

        final List<RouteMatch>? subRouteMatch = _getLocRouteRecursively(
          location: location,
          remainingLocation: childRestLoc,
          matchedLocation: newParentSubLoc,
          pathParameters: subPathParameters,
          children: route.children,
        );

        // If there's no sub-route matches, there is no match for this location
        if (subRouteMatch == null) {
          continue;
        }
        result = <RouteMatch>[match, ...subRouteMatch];
      }
      // Should only reach here if there is a match.
      break;
    }
    if (result != null) {
      pathParameters.addAll(subPathParameters);
    }
    return result;
  }

  /// Processes redirects by returning a new [RouteMatchList] representing the new
  /// location.
  FutureOr<RouteMatchList> redirect(
      BuildContext context, FutureOr<RouteMatchList> prevMatchListFuture,
      {required List<RouteMatchList> redirectHistory}) {
    FutureOr<RouteMatchList> processRedirect(RouteMatchList prevMatchList) {
      final String prevLocation = prevMatchList.uri.toString();
      FutureOr<RouteMatchList> processTopLevelRedirect(
          String? topRedirectLocation) {
        if (topRedirectLocation != null &&
            topRedirectLocation != prevLocation) {
          final RouteMatchList newMatch = _getNewMatches(
            topRedirectLocation,
            prevMatchList.uri,
            redirectHistory,
          );
          if (newMatch.isError) {
            return newMatch;
          }
          return redirect(
            context,
            newMatch,
            redirectHistory: redirectHistory,
          );
        }

        FutureOr<RouteMatchList> processRouteLevelRedirect(
            String? routeRedirectLocation) {
          if (routeRedirectLocation != null &&
              routeRedirectLocation != prevLocation) {
            final RouteMatchList newMatch = _getNewMatches(
              routeRedirectLocation,
              prevMatchList.uri,
              redirectHistory,
            );

            if (newMatch.isError) {
              return newMatch;
            }
            return redirect(
              context,
              newMatch,
              redirectHistory: redirectHistory,
            );
          }
          return prevMatchList;
        }

        final FutureOr<String?> routeLevelRedirectResult =
            _getRouteLevelRedirect(context, prevMatchList, 0);
        if (routeLevelRedirectResult is String?) {
          return processRouteLevelRedirect(routeLevelRedirectResult);
        }
        return routeLevelRedirectResult
            .then<RouteMatchList>(processRouteLevelRedirect);
      }

      redirectHistory.add(prevMatchList);
      // Check for top-level redirect
      final FutureOr<String?> topRedirectResult = topRedirect(
        context,
        buildTopLevelZeroRouterState(prevMatchList),
      );

      if (topRedirectResult is String?) {
        return processTopLevelRedirect(topRedirectResult);
      }
      return topRedirectResult.then<RouteMatchList>(processTopLevelRedirect);
    }

    if (prevMatchListFuture is RouteMatchList) {
      return processRedirect(prevMatchListFuture);
    }
    return prevMatchListFuture.then<RouteMatchList>(processRedirect);
  }

  FutureOr<String?> _getRouteLevelRedirect(
    BuildContext context,
    RouteMatchList matchList,
    int currentCheckIndex,
  ) {
    if (currentCheckIndex >= matchList.matches.length) {
      return null;
    }
    final RouteMatch match = matchList.matches[currentCheckIndex];
    FutureOr<String?> processRouteRedirect(String? newLocation) =>
        newLocation ??
        _getRouteLevelRedirect(context, matchList, currentCheckIndex + 1);
    final ZeroPage route = match.route;
    FutureOr<String?> routeRedirectResult;
    if (route.redirect != null) {
      routeRedirectResult = route.redirect!(
        context,
        ZeroRouterState(
          this,
          location: matchList.uri.toString(),
          matchedLocation: match.matchedLocation,
          name: route.id,
          path: route.path,
          fullPath: matchList.fullPath,
          extra: matchList.extra,
          pathParameters: matchList.pathParameters,
          queryParameters: matchList.uri.queryParameters,
          queryParametersAll: matchList.uri.queryParametersAll,
          pageKey: match.pageKey,
        ),
      );
    }
    if (routeRedirectResult is String?) {
      return processRouteRedirect(routeRedirectResult);
    }
    return routeRedirectResult.then<String?>(processRouteRedirect);
  }

  RouteMatchList _getNewMatches(
    String newLocation,
    Uri previousLocation,
    List<RouteMatchList> redirectHistory,
  ) {
    try {
      final RouteMatchList newMatch = findMatch(newLocation);
      _addRedirect(redirectHistory, newMatch, previousLocation);
      return newMatch;
    } on ZeroException catch (e) {
      log.info('Redirection exception: ${e.message}');
      return _errorRouteMatchList(previousLocation, e);
    }
  }

  /// Adds the redirect to [redirects] if it is valid.
  ///
  /// Throws if a loop is detected or the redirection limit is reached.
  void _addRedirect(
    List<RouteMatchList> redirects,
    RouteMatchList newMatch,
    Uri prevLocation,
  ) {
    if (redirects.contains(newMatch)) {
      throw ZeroException(
          'redirect loop detected ${_formatRedirectionHistory(<RouteMatchList>[
            ...redirects,
            newMatch
          ])}');
    }
    if (redirects.length > redirectLimit) {
      throw ZeroException(
          'too many redirects ${_formatRedirectionHistory(<RouteMatchList>[
            ...redirects,
            newMatch
          ])}');
    }

    redirects.add(newMatch);

    log.info('redirecting to $newMatch');
  }

  String _formatRedirectionHistory(List<RouteMatchList> redirections) {
    return redirections
        .map<String>(
            (RouteMatchList routeMatches) => routeMatches.uri.toString())
        .join(' => ');
  }

  /// Get the location for the provided route.
  ///
  /// Builds the absolute path for the route, by concatenating the paths of the
  /// route and all its ancestors.
  String? locationForRoute(ZeroPage route) =>
      fullPathForRoute(route, '', pages);

  @override
  String toString() {
    return 'RouterConfiguration: $pages';
  }

  /// Returns the full path of [pages].
  ///
  /// Each path is indented based depth of the hierarchy, and its `name`
  /// is also appended if not null
  @visibleForTesting
  String debugKnownRoutes() {
    final StringBuffer sb = StringBuffer();
    sb.writeln('Full paths for routes:');
    _debugFullPathsFor(pages, '', 0, sb);

    if (_nameToPath.isNotEmpty) {
      sb.writeln('known full paths for route names:');
      for (final MapEntry<String, String> e in _nameToPath.entries) {
        sb.writeln('  ${e.key} => ${e.value}');
      }
    }

    return sb.toString();
  }

  void _debugFullPathsFor(List<ZeroPage> routes, String parentFullpath,
      int depth, StringBuffer sb) {
    for (final ZeroPage route in routes) {
      final String fullPath = concatenatePaths(parentFullpath, route.path);
      sb.writeln('  => ${''.padLeft(depth * 2)}$fullPath');
      _debugFullPathsFor(route.children, fullPath, depth + 1, sb);
    }
  }

  void _cacheNameToPath(String parentFullPath, List<ZeroPage> childRoutes) {
    for (final ZeroPage route in childRoutes) {
      final String fullPath = concatenatePaths(parentFullPath, route.path);

      final String name = route.id;
      assert(
          !_nameToPath.containsKey(name),
          'duplication fullpaths for name '
          '"$name":${_nameToPath[name]}, $fullPath');
      _nameToPath[name] = fullPath;

      if (route.children.isNotEmpty) {
        _cacheNameToPath(fullPath, route.children);
      }
    }
  }
}
