import 'package:flutter_hooks/flutter_hooks.dart';
import '../../onezero.dart';

class OneZeroApp extends HookConsumerWidget with WidgetsBindingObserver {
  const OneZeroApp({
    super.key,
    this.pages = const [],
    this.theme,
  });

  final ZeroTheme? theme;
  final List<ZeroPage> pages;

  Widget _buildWidgetApp(BuildContext context) {
    return ProviderScope(
      child: ThemeScope(
        theme: theme ?? defaultTheme,
        child: ContainerColorsScope(
          colors: (theme ?? defaultTheme).colors.scaffold,
          child: WidgetsApp.router(
            key: GlobalObjectKey(this),
            color: const Color.fromARGB(255, 98, 0, 238),
            routerConfig: ZeroRouter(
              pages: pages,
            ),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heroController = useState(HeroController());
    Widget result = _buildWidgetApp(context);
    result = Focus(
      canRequestFocus: false,
      child: result,
    );
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: HeroControllerScope(
        controller: heroController.value,
        child: result,
      ),
    );
  }
}

class OneZeroScrollBehavior extends ScrollBehavior {
  const OneZeroScrollBehavior();

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    switch (axisDirectionToAxis(details.direction)) {
      case Axis.horizontal:
        return child;
      case Axis.vertical:
        switch (getPlatform(context)) {
          case TargetPlatform.macOS:
          case TargetPlatform.linux:
          case TargetPlatform.windows:
            assert(details.controller != null);
            return Scrollbar(
              controller: details.controller,
              child: child,
            );
          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
          case TargetPlatform.iOS:
            return child;
        }
    }
  }

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    // Currently there is no overscroll indicator in the design.
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    if (getPlatform(context) == TargetPlatform.macOS) {
      return const BouncingScrollPhysics();
    }
    return const BouncingScrollPhysics();
  }
}
