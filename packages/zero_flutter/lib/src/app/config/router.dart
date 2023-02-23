import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zero_flutter/zero_flutter.dart';

export '../fallback_page.dart';

GlobalKey<NavigatorState> oneZeroNav = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> omniNav = GlobalKey<NavigatorState>();

class RouterEntry {
  final int level;
  final Page page;

  const RouterEntry({
    required this.level,
    required this.page,
  });
}

class Router {
  Router(
    BuildContext context, {
    required this.pages,
    required this.authConfig,
    this.initialPage,
  }) : goRouter = GoRouter(
          initialLocation: initialPage?.metadata(context).path ?? "/",
          redirect: (context, state) {
            Future.delayed(Duration.zero, () {
              // update isRoot
              globalContainer.read(Router.isRoot.notifier).state =
                  (state.location == "/");
            });

            final loggedIn = FirebaseAuth.instance.currentUser != null;
            if (authConfig.isSignInEnabled &&
                !authConfig.anonymousEnabled &&
                !loggedIn) {
              return authConfig.signInLink;
            } else if (loggedIn && state.location == authConfig.signInLink) {
              return initialPage?.metadata(context).path ?? "/";
            }

            return null;
          },
          errorPageBuilder: (context, state) => TransitionPage(
            inDirection: AxisDirection.left,
            outDirection: AxisDirection.left,
            level: 0,
            key: ValueKey(state.path),
            name: "Not Found",
            child: const Scaffold(
              body: FallbackPage(),
            ),
          ),
          routes: [
            ShellRoute(
              navigatorKey: omniNav,
              pageBuilder: (context, state, child) => TransitionPage(
                level: 0,
                key: ValueKey(state.path),
                name: state.name,
                child: AdaptiveContextProvider(
                  child: OmniScaffold(
                    key: ValueKey(state.path),
                    child: child,
                  ),
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
                ...pages
                    .map(
                      (page) => page.route(
                        context,
                        level: 1,
                      ),
                    )
                    .whereType<RouteBase>()
                    .toList(),
              ],
            )
          ],
          navigatorKey: oneZeroNav,
        );

  final AuthConfig authConfig;
  final Page? initialPage;
  final List<Page> pages;
  final GoRouter goRouter;

  static final isRoot = StateProvider<bool>((ref) => true);

  String get currentPath => goRouter.location;

  int get level {
    // update level
    String current = currentPath;
    // remove leading slash
    if (current.startsWith("/")) {
      current = current.substring(1);
    }
    // remove trailing slash
    if (current.endsWith("/")) {
      current = current.substring(0, current.length - 1);
    }

    return current.isEmpty ? 0 : current.split("/").length;
  }

  PageMetadata? currentPage(BuildContext context) {
    return pages.map((page) => page.metadata(context)).firstWhere(
          (metadata) => metadata.path == currentPath,
          orElse: () => PageMetadata(
            name: (context) =>
                ZeroUIAppLocalizations.of(context)!.fallbackPageTitle,
            path: "/",
          ),
        );
  }

  go(String path) => goRouter.go(path);
}
