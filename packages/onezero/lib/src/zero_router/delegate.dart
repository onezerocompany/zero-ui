import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../onezero.dart';

/// ZeroRouter implementation of [RouterDelegate].
class ZeroRouterDelegate extends RouterDelegate<RouteMatchList>
    with ChangeNotifier {
  /// Constructor for ZeroRouter's implementation of the RouterDelegate base
  /// class.
  ZeroRouterDelegate({
    required RouteConfiguration configuration,
    required ZeroRouterBuilderWithNav builderWithNav,
    required ZeroRouterPageBuilder? errorPageBuilder,
    required ZeroRouterWidgetBuilder? errorBuilder,
    required List<NavigatorObserver> observers,
    required this.routerNeglect,
    required this.onException,
    String? restorationScopeId,
  }) : _configuration = configuration {
    builder = RouteBuilder(
      configuration: configuration,
      builderWithNav: builderWithNav,
      errorPageBuilder: errorPageBuilder,
      errorBuilder: errorBuilder,
      restorationScopeId: restorationScopeId,
      observers: observers,
      onPopPageWithRouteMatch: _handlePopPageWithRouteMatch,
    );
  }

  /// Builds the top-level Navigator given a configuration and location.
  @visibleForTesting
  late final RouteBuilder builder;

  /// Set to true to disable creating history entries on the web.
  final bool routerNeglect;

  /// The exception handler that is called when parser can't handle the incoming
  /// uri.
  ///
  /// If this is null, the exception is handled in the
  /// [RouteBuilder.errorPageBuilder] or [RouteBuilder.errorBuilder].
  final ZeroRouterExceptionHandler? onException;

  final RouteConfiguration _configuration;

  _NavigatorStateIterator _createNavigatorStateIterator() =>
      _NavigatorStateIterator(currentConfiguration, navigatorKey.currentState!);

  @override
  Future<bool> popRoute() async {
    final _NavigatorStateIterator iterator = _createNavigatorStateIterator();
    while (iterator.moveNext()) {
      final bool didPop = await iterator.current.maybePop();
      if (didPop) {
        return true;
      }
    }
    return false;
  }

  /// Returns `true` if the active Navigator can pop.
  bool canPop() {
    final _NavigatorStateIterator iterator = _createNavigatorStateIterator();
    while (iterator.moveNext()) {
      if (iterator.current.canPop()) {
        return true;
      }
    }
    return false;
  }

  /// Pops the top-most route.
  void pop<T extends Object?>([T? result]) {
    final _NavigatorStateIterator iterator = _createNavigatorStateIterator();
    while (iterator.moveNext()) {
      if (iterator.current.canPop()) {
        iterator.current.pop<T>(result);
        return;
      }
    }
    throw ZeroError('There is nothing to pop');
  }

  void _debugAssertMatchListNotEmpty() {
    assert(
      currentConfiguration.isNotEmpty,
      'You have popped the last page off of the stack,'
      ' there are no pages left to show',
    );
  }

  bool _handlePopPageWithRouteMatch(
      Route<Object?> route, Object? result, RouteMatch? match) {
    if (!route.didPop(result)) {
      return false;
    }
    assert(match != null);
    if (match is ImperativeRouteMatch) {
      match.complete(result);
    }
    currentConfiguration = currentConfiguration.remove(match!);
    notifyListeners();
    assert(() {
      _debugAssertMatchListNotEmpty();
      return true;
    }());
    return true;
  }

  /// For use by the Router architecture as part of the RouterDelegate.
  GlobalKey<NavigatorState> get navigatorKey => _configuration.navigatorKey;

  /// For use by the Router architecture as part of the RouterDelegate.
  @override
  RouteMatchList currentConfiguration = RouteMatchList.empty;

  /// For use by the Router architecture as part of the RouterDelegate.
  @override
  Widget build(BuildContext context) {
    return builder.build(
      context,
      currentConfiguration,
      routerNeglect,
    );
  }

  /// For use by the Router architecture as part of the RouterDelegate.
  @override
  Future<void> setNewRoutePath(RouteMatchList configuration) {
    if (currentConfiguration != configuration) {
      currentConfiguration = configuration;
      notifyListeners();
    }
    assert(currentConfiguration.isNotEmpty || currentConfiguration.isError);
    // Use [SynchronousFuture] so that the initial url is processed
    // synchronously and remove unwanted initial animations on deep-linking
    return SynchronousFuture<void>(null);
  }
}

/// An iterator that iterates through navigators that [ZeroRouterDelegate]
/// created from the inner to outer.
///
/// The iterator starts with the navigator that hosts the top-most route. This
/// navigator may not be the inner-most navigator if the top-most route is a
/// pageless route, such as a dialog or bottom sheet.
class _NavigatorStateIterator implements Iterator<NavigatorState> {
  _NavigatorStateIterator(this.matchList, this.root)
      : index = matchList.matches.length - 1;

  final RouteMatchList matchList;
  int index;

  final NavigatorState root;
  @override
  late NavigatorState current;

  ZeroPage _getRouteAtIndex(int index) => matchList.matches[index].route;

  void _findsNextIndex() {
    final GlobalKey<NavigatorState>? parentNavigatorKey =
        _getRouteAtIndex(index).parentNavigatorKey;
    if (parentNavigatorKey == null) {
      index -= 1;
      return;
    }

    assert(root == parentNavigatorKey.currentState);
  }

  @override
  bool moveNext() {
    if (index < 0) {
      return false;
    }
    _findsNextIndex();

    while (index >= 0) {
      _findsNextIndex();
    }
    assert(index == -1);
    current = root;
    return true;
  }
}
