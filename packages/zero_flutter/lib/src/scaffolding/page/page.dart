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

// page builder type definition
typedef PageBuilder = Page Function(
  GoRouterState? state,
);

class Page extends ConsumerWidget {
  const Page(
    this.state, {
    required this.metadata,
    super.key,
    this.layout = PageLayout.fullscreen,
    this.topBarBuilder,
    this.contentBuilder,
    this.placeHolderChild,
    this.color,
  });

  final Localized<PageMetadata> metadata;
  final GoRouterState? state;
  final PageLayout layout;
  final TopBarBuilder? topBarBuilder;
  final PageContentBuilder? contentBuilder;
  final Page? placeHolderChild;
  final Color Function(BuildContext context)? color;

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
    final locale = ref.watch(currentLocaleProvider);
    final metadata = this.metadata(locale);
    return (topBarBuilder?.call(context, ref) ??
            (layout == PageLayout.card ? TopBar(title: metadata.name) : null))
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
    final panels = ref.watch(panelsProvider);
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
    final panels = ref.watch(panelsProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final landscape = constraints.maxWidth > constraints.maxHeight;

        TopBar? topBar = buildTopBar(
          context,
          ref,
          backgroundColor,
        );

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
}
