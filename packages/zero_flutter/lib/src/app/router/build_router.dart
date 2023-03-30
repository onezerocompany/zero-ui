import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:zero_flutter/zero_flutter.dart';

import 'build_entries.dart';
import 'refresh_stream.dart';
import 'route_from_entry.dart';
import 'fallback_page.dart';

GoRouter buildRouter(
  Locale locale, {
  required List<PageBuilder> pages,
  required String initialPath,
}) {
  final entries = buildEntries(locale, pages);
  return GoRouter(
    initialLocation: initialPath,
    redirect: (context, state) {
      // Update current entry
      final authConfig = globalContainer.read(authConfigProvider);
      final loggedIn = globalContainer.read(userIdProvider).valueOrNull != null;
      final router = globalContainer.read(routerProvider);
      final entry = router.entryForPaths([
        state.location,
        state.fullpath,
        state.path,
        state.subloc,
      ]);

      if (entry != null) {
        Future.delayed(Duration.zero, () {
          globalContainer
              .read(currentRouterEntryProvider.notifier)
              .update(entry);
        });
        final metadata = entry.metadata;
        final allowed = metadata.hasAccess?.call() ?? false;
        if (!allowed && !loggedIn && entry.fullPath != authConfig.signInLink) {
          return authConfig.signInLink;
        } else if (!allowed && loggedIn) {
          return router.initialPath;
        } else if (loggedIn && entry.fullPath == authConfig.signInLink) {
          return router.initialPath;
        }
      }
      return null;
    },
    errorPageBuilder: (context, state) => TransitionPage(
      entry: null,
      inDirection: AxisDirection.left,
      outDirection: AxisDirection.left,
      level: 0,
      key: state.pageKey,
      name: "Not Found",
      child: Scaffold(
        body: FallbackPage(
          null,
          metadata: (locale) => const PageMetadata(
            path: "/fallback",
            name: "Fallback",
            searchable: false,
          ),
        ),
      ),
    ),
    routes: [
      ShellRoute(
        navigatorKey: omniNav,
        pageBuilder: (context, state, child) => TransitionPage(
          entry: null,
          level: 0,
          key: state.pageKey,
          name: state.name,
          child: OmniScaffold(
            child: child,
          ),
        ),
        routes: [
          GoRoute(
            path: "/",
            pageBuilder: (context, state) => TransitionPage(
              entry: null,
              level: 1,
              key: state.pageKey,
              name: state.name,
              child: Container(),
            ),
          ),
          ...entries
              .map(
                (entry) => routeFromEntry(
                  level: 1,
                  entry: entry,
                ),
              )
              .toList(),
        ],
      )
    ],
    navigatorKey: oneZeroNav,
    // convert FirebaseAuth authStateChanges to a listenable
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges().asBroadcastStream(),
    ),
  );
}
