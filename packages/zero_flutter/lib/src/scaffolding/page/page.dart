import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zero_flutter/zero_flutter.dart';

export 'page_metadata.dart';

// components
export 'page_content.dart';
export 'page_structure.dart';
export 'top_bar.dart';

// helpers
export '../../utils/blur_fader.dart';
export 'card_layout.dart';
export 'transition_page.dart';

enum PageLayout {
  fullscreen,
  card,
  fullscreenCard,
}

class Page extends ConsumerWidget {
  const Page({
    super.key,
    this.layout = PageLayout.fullscreen,
    this.topBarBuilder,
    this.contentBuilder,
    this.placeHolderChild,
    this.color,
  });

  final PageLayout layout;
  final TopBarBuilder? topBarBuilder;
  final PageContentBuilder? contentBuilder;
  final Page? placeHolderChild;
  final Color Function(BuildContext context)? color;

  PageMetadata metadata(BuildContext context) {
    return PageMetadata(
      path: "/",
      name: (context) => "Page",
      description: (context) => "A page",
      icon: Icons.home,
    );
  }

  @protected
  Color backgroundColor(BuildContext context) {
    if (color != null) return color!.call(context);
    ColorScheme colors = Theme.of(context).colorScheme;
    if (layout == PageLayout.card) {
      return colors.background;
    } else {
      return colors.surface;
    }
  }

  @protected
  TopBar? buildTopBar(
    BuildContext context,
    WidgetRef ref,
    Color backgroundColor,
  ) {
    final metadata = this.metadata(context);
    return (topBarBuilder?.call(context, ref) ??
            (layout == PageLayout.card
                ? TopBar(
                    title: metadata.name?.call(context),
                    subtitle: metadata.description?.call(context),
                  )
                : null))
        ?.copyWith(backgroundColor: backgroundColor);
  }

  @protected
  PageContent? buildContent(
    BuildContext context,
    WidgetRef ref,
    Color backgroundColor,
    TopBar? topBar,
    bool landscape,
  ) {
    final panels = AdaptiveContext.panels(context);
    final content = contentBuilder?.call(context, ref, landscape);
    final actualLayout = panels < 2
        ? (layout == PageLayout.card ? PageLayout.fullscreenCard : layout)
        : layout;
    return content?.copyWith(
      hasTopBar: topBar?.isVisible == true,
      landscape: landscape,
      backgroundColor: backgroundColor,
      layout: actualLayout,
    );
  }

  @protected
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = this.backgroundColor(context);
    final panels = AdaptiveContext.panels(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final landscape = constraints.maxWidth > constraints.maxHeight;
        TopBar? topBar = buildTopBar(context, ref, backgroundColor);
        PageContent? content = buildContent(
          context,
          ref,
          backgroundColor,
          topBar,
          landscape,
        );

        bool isDark = backgroundColor.computeLuminance() < 0.5;
        StatusBarStyle statusBarDetermined =
            (content?.statusBarStyle ?? topBar?.statusBarStyle) ??
                (isDark ? StatusBarStyle.light : StatusBarStyle.dark);

        final actualLayout = panels < 2
            ? (layout == PageLayout.card ? PageLayout.fullscreenCard : layout)
            : layout;

        return StatusBarHelper(
          style: statusBarDetermined,
          child: PageCardLayout(
            cardColor: backgroundColor,
            backgroundColor: color?.call(context),
            layout: actualLayout,
            structure: PageStructure(
              content: content,
              landscape: landscape,
              layout: actualLayout,
              topBar: topBar,
            ),
          ),
        );
      },
    );
  }

  RouteBase? route(
    BuildContext context, {
    Page? parent,
    required int level,
  }) {
    final metadata = this.metadata(context);
    final path = metadata.resolvedPath(
      context,
      parent: parent,
    );
    final subroutes = metadata.subroutes(
      context,
      parent: this,
      level: level + 1,
    );
    if (subroutes.isNotEmpty == true) {
      return ShellRoute(
        pageBuilder: (context, state, child) => TransitionPage(
          inDirection: AxisDirection.left,
          outDirection: AxisDirection.left,
          level: level,
          key: ValueKey(state.path ?? path),
          name: metadata.name?.call(context),
          child: HeroControllerScope(
            controller: HeroController(
              createRectTween: (begin, end) =>
                  MaterialRectArcTween(begin: begin, end: end),
            ),
            child: MultiPageScaffold(
              key: ValueKey(state.path ?? path),
              leftPage: this,
              rightPage: child,
            ),
          ),
        ),
        routes: [
          GoRoute(
            path: path,
            pageBuilder: (context, state) => TransitionPage(
              inDirection: AxisDirection.up,
              outDirection: AxisDirection.up,
              level: level + 1,
              key: ValueKey(state.path ?? path),
              name: metadata.name?.call(context),
              child: placeHolderChild ?? const SizedBox.expand(),
            ),
            routes: subroutes,
          ),
        ],
      );
    } else {
      return GoRoute(
        path: path,
        pageBuilder: (context, state) => TransitionPage(
          inDirection: AxisDirection.up,
          outDirection: AxisDirection.up,
          level: level,
          key: ValueKey(state.path ?? path),
          name: metadata.name?.call(context),
          child: this,
        ),
      );
    }
  }
}
