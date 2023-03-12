import 'package:zero_flutter/zero_flutter.dart';

class RouterObserver extends NavigatorObserver {
  RouterObserver();

  @override
  didPop(Route route, Route? previousRoute) {
    Future.delayed(Duration.zero, () {
      final router = globalContainer.read(routerProvider);
      final entry = router.entryForPath(router.goRouter.location);
      globalContainer.read(currentRouterEntryProvider.notifier).update(entry);
    });
  }
}
