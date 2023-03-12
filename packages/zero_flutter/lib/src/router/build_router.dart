import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:zero_flutter/zero_flutter.dart';

import 'build_entries.dart';
import 'refresh_stream.dart';
import 'route_from_entry.dart';

GoRouter buildRouter(
  Locale locale, {
  required List<PageBuilder> pages,
  required String initialPath,
}) {
  final entries = buildEntries(locale, pages);
  return GoRouter(
    initialLocation: initialPath,
    errorPageBuilder: (context, state) => TransitionPage(
      inDirection: AxisDirection.left,
      outDirection: AxisDirection.left,
      level: 0,
      key: ValueKey(state.path),
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
          level: 0,
          key: ValueKey(state.path),
          name: state.name,
          child: OmniScaffold(
            key: ValueKey(state.path),
            child: child,
          ),
        ),
        routes: [
          GoRoute(
            path: "/",
            pageBuilder: (context, state) => TransitionPage(
              level: 1,
              key: ValueKey(state.path),
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
