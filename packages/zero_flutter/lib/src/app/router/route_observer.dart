import 'package:zero_flutter/zero_flutter.dart';

class RouterObserver extends NavigatorObserver {
  RouterObserver();

  @override
  didPop(Route route, Route? previousRoute) {
    Future.delayed(Duration.zero, () {
      final entry = (previousRoute?.settings as TransitionPage?)?.entry;
      if (entry != null) {
        globalContainer.read(currentRouterEntryProvider.notifier).update(entry);
      }
    });
  }
}
