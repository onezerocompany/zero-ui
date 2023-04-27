import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';
import 'package:zero_ui/zero_ui.dart';

import 'build_entries.dart';
import 'build_router.dart';

export 'router_entry.dart';

part 'router.g.dart';

GlobalKey<NavigatorState> oneZeroNav = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> omniNav = GlobalKey<NavigatorState>();

@riverpod
Router router(RouterRef ref) {
  final config = ref.watch(appConfigProvider);
  return config.router;
}

@riverpod
class CurrentRouterEntry extends _$CurrentRouterEntry {
  @override
  RouterEntry? build() {
    return null;
  }

  void update(RouterEntry? entry) {
    if (entry != null) state = entry;
  }
}

@riverpod
int currentRouterLevel(CurrentRouterLevelRef ref) {
  final entry = ref.watch(currentRouterEntryProvider);
  return entry?.level ?? 0;
}

class Router {
  Router(
    Locale locale, {
    List<PageBuilder> pages = const [],
    this.initialPath = "/",
  })  : entries = buildEntries(locale, pages),
        goRouter = buildRouter(
          locale,
          initialPath: initialPath,
          pages: pages,
        );

  final String initialPath;
  final List<RouterEntry> entries;
  final GoRouter goRouter;

  // All entries, including subentries (recursive)
  static List<RouterEntry> expandedEntries(
    List<RouterEntry> entries,
  ) {
    return entries
        .expand((entry) => [entry, ...expandedEntries(entry.subentries)])
        .toList();
  }

  // Returns the page for an array of paths
  // If no path is found, returns null
  RouterEntry? entryForPaths(
    List<String?> paths,
  ) {
    // sort the paths by amount of sections (aka '/')
    // so that the longest path is checked first
    // this is to prevent a path like '/a/b' from being
    // matched by '/a' if '/a' is the first path in the list
    final sortedPaths = paths
      ..sort(
        (a, b) => (b?.split('/').length ?? 0) - (a?.split('/').length ?? 0),
      );
    return sortedPaths.isEmpty
        ? null
        : expandedEntries(entries).firstWhereOrNull(
            (entry) => paths.contains(entry.fullPath),
          );
  }

  // Navigate to a page
  void go(String path) {
    final router = globalContainer.read(routerProvider);
    final entry = router.entryForPaths([path]);
    final allowed = entry?.metadata.hasAccess?.call() ?? true;
    if (allowed && path != goRouter.location) {
      goRouter.go(path);
    }
  }
}
