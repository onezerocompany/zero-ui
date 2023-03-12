import 'package:go_router/go_router.dart';
import 'package:zero_flutter/zero_flutter.dart';

import 'build_entries.dart';
import 'build_router.dart';
import 'router_entry.dart';

export '../app/fallback_page.dart';

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
    state = entry;
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

  // Returns the page for a given full path
  RouterEntry? entryForPath(String? path) => path == null
      ? null
      : expandedEntries(entries).firstWhereOrNull(
          (entry) => entry.fullPath == path,
        );

  // Navigate to a page
  void go({
    RouterEntry? entry,
    String? path,
  }) {
    final entryPath = entry?.fullPath ?? path;
    if (entryPath != null && entryPath != goRouter.location) {
      goRouter.go(entryPath);
    }
  }
}
