import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:zero_ui/zero_ui.dart';

import 'route_observer.dart';

String? redirect(BuildContext context, GoRouterState state) {
  // Update current entry
  final authConfig = globalContainer.read(authConfigProvider);
  final loggedIn = globalContainer.read(userIdProvider).valueOrNull != null;
  final router = globalContainer.read(routerProvider);
  final entry = router.entryForPaths([
    state.fullpath,
    state.location,
    state.path,
    state.subloc,
  ]);

  if (entry != null) {
    Future.delayed(Duration.zero, () {
      globalContainer.read(currentRouterEntryProvider.notifier).update(entry);
    });
    final metadata = entry.metadata;
    final allowed = metadata.hasAccess?.call() ?? false;
    if (!allowed && !loggedIn && entry.fullPath != authConfig.signInLink) {
      return authConfig.signInLink;
    } else if (!allowed && loggedIn) {
      return state.fullpath;
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
        entry: entry,
        inDirection: AxisDirection.up,
        outDirection: AxisDirection.up,
        level: level,
        key: state.pageKey,
        name: entry.metadata.name,
        child:
            entry.pageBuilder(null).layout == PageLayout.fullscreen || level > 1
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
        entry: entry,
        inDirection: AxisDirection.left,
        outDirection: AxisDirection.left,
        level: level,
        key: state.pageKey,
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
          path: level == 1 ? entry.fullPath : entry.subPath,
          pageBuilder: (context, state) => TransitionPage(
            entry: entry,
            inDirection: AxisDirection.up,
            outDirection: AxisDirection.up,
            level: level + 1,
            key: state.pageKey,
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
