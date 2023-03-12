import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:zero_flutter/zero_flutter.dart';

import 'route_observer.dart';
import 'router_entry.dart';

FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
  // Update current entry
  final router = globalContainer.read(routerProvider);
  final authConfig = globalContainer.read(authConfigProvider);

  final entry = router.entryForPath(state.fullpath);
  final loggedIn = globalContainer.read(userIdProvider).valueOrNull != null;

  if (entry != null) {
    Future.delayed(Duration.zero, () {
      globalContainer.read(currentRouterEntryProvider.notifier).update(entry);
    });
    final metadata = entry.metadata;
    final allowed = metadata.hasAccess;
    if (!allowed && !loggedIn && entry.fullPath != authConfig.signInLink) {
      return authConfig.signInLink;
    } else if (loggedIn && entry.fullPath == authConfig.signInLink) {
      return router.initialPath;
    }
  }
  return null;
}

RouteBase routeFromEntry({
  int level = 1,
  required RouterEntry entry,
}) {
  if (entry.subentries.isEmpty) {
    // if no subentries, return a GoRoute
    return GoRoute(
      // if level is 0, use the full path
      path: level == 1 ? entry.fullPath : entry.subPath,
      pageBuilder: (context, state) => TransitionPage(
        inDirection: AxisDirection.up,
        outDirection: AxisDirection.up,
        level: level,
        key: ValueKey(entry.fullPath),
        name: entry.metadata.name,
        // child: entry.pageBuilder(state),
        child: level >= 1
            ? entry.pageBuilder(state)
            : MultiPageScaffold(
                key: ValueKey('${entry.fullPath}-scaffold'),
                leftPage: entry.pageBuilder(state),
              ),
      ),
      redirect: redirect,
    );
  } else {
    // if subentries, return a ShellRoute
    return ShellRoute(
      observers: [
        RouterObserver(),
      ],
      pageBuilder: (context, state, child) => TransitionPage(
        inDirection: AxisDirection.left,
        outDirection: AxisDirection.left,
        level: level,
        key: ValueKey('${entry.fullPath}-shellroute'),
        name: entry.metadata.name,
        child: HeroControllerScope(
          controller: HeroController(
            createRectTween: (begin, end) =>
                MaterialRectArcTween(begin: begin, end: end),
          ),
          child: MultiPageScaffold(
            key: ValueKey('${entry.fullPath}-scaffold'),
            leftPage: entry.pageBuilder(state),
            rightPage: child,
          ),
        ),
      ),
      routes: [
        GoRoute(
          // if level is 0, use the full path
          path: level == 1 ? entry.fullPath : entry.subPath,
          pageBuilder: (context, state) => TransitionPage(
            inDirection: AxisDirection.up,
            outDirection: AxisDirection.up,
            level: level + 1,
            key: ValueKey(entry.fullPath),
            name: entry.metadata.name,
            child: entry.pageBuilder(null).placeHolderChild ??
                const SizedBox.expand(),
          ),
          routes: entry.subentries.map((entry) {
            return routeFromEntry(
              level: level + 1,
              entry: entry,
            );
          }).toList(),
          redirect: redirect,
        ),
      ],
    );
  }
}
