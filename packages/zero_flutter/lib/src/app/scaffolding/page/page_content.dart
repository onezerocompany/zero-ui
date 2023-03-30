import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zero_flutter/zero_flutter.dart';

// A widget that contains the actual content of the page
class PageContent<ItemType> extends ConsumerWidget {
  const PageContent({
    super.key,
    this.child,
    this.slivers,
    this.itemBuilder,
    this.leadingItems,
    this.trailingItems,
    this.itemSpacing = 12,
    this.query,
    this.maxWidth = double.infinity,
    this.fadeEdges = true,
    this.extend = false,
    this.scrollable = true,
    this.landscape = false,
    this.hasTopBar = false,
    this.backgroundColor = Colors.transparent,
    this.statusBarStyle,
    this.layout = PageLayout.fullscreen,
  });

  final Widget? child;

  final List<Widget>? slivers;

  final Widget Function(DocumentSnapshot item)? itemBuilder;
  final List<Widget>? leadingItems;
  final List<Widget>? trailingItems;
  final double itemSpacing;
  final Query? query;

  final bool fadeEdges;
  final bool extend;
  final double maxWidth;
  final bool scrollable;
  final Color backgroundColor;
  final StatusBarStyle? statusBarStyle;
  final PageLayout layout;

  // state
  final bool landscape;
  final bool hasTopBar;

  copyWith({
    Key? key,
    bool? extend,
    bool? scrollable,
    bool? landscape,
    bool? hasTopBar,
    Color? backgroundColor,
    StatusBarStyle? statusBarStyle,
    double? maxWidth,
    Widget? child,
    Widget Function(dynamic item)? itemBuilder,
    List<Widget>? leadingItems,
    List<Widget>? trailingItems,
    double? itemSpacing,
    Query? query,
    List<Widget>? slivers,
    PageLayout? layout,
  }) {
    return PageContent(
      key: key ?? this.key,
      extend: extend ?? this.extend,
      scrollable: scrollable ?? this.scrollable,
      landscape: landscape ?? this.landscape,
      hasTopBar: hasTopBar ?? this.hasTopBar,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      statusBarStyle: statusBarStyle ?? this.statusBarStyle,
      maxWidth: maxWidth ?? this.maxWidth,
      itemBuilder: itemBuilder ?? this.itemBuilder,
      leadingItems: leadingItems ?? this.leadingItems,
      trailingItems: trailingItems ?? this.trailingItems,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      query: query ?? this.query,
      slivers: slivers ?? this.slivers,
      layout: layout ?? this.layout,
      child: child ?? this.child,
    );
  }

  static EdgeInsets padding(
    BuildContext context,
    WidgetRef ref, {
    required bool extend,
    required bool fadeEdges,
    required bool offsetBar,
    required PageLayout layout,
  }) {
    if (extend) return EdgeInsets.zero;
    final style = ref.watch(styleConfigProvider);
    final panels = ref.watch(panelsProvider);
    final breakpoint = ref.watch(breakPointProvider);
    final contentPadding = style.contentPadding.value(breakpoint);
    final gutters = style.gutters.value(breakpoint);
    final fullscreen =
        layout == PageLayout.fullscreen || layout == PageLayout.fullscreenCard;
    final useGutter = fullscreen || (panels > 1 && layout != PageLayout.card);
    final barHeight = offsetBar
        ? OmniBar.resolvedHeight(
              context,
              ref,
              open: false,
              searching: false,
              docked: false,
              breakpoint: breakpoint,
            ) +
            gutters
        : 0;
    final safeAreaInsets = MediaQuery.of(context).padding;
    return EdgeInsets.only(
      top: max(
        (useGutter ? gutters : contentPadding.top) + safeAreaInsets.top,
        fadeEdges && layout == PageLayout.card ? 60 : 0,
      ),
      left: (useGutter ? gutters : contentPadding.left) + safeAreaInsets.left,
      right:
          (useGutter ? gutters : contentPadding.right) + safeAreaInsets.right,
      bottom: max(
        (useGutter ? gutters : contentPadding.bottom) +
            safeAreaInsets.bottom +
            barHeight,
        fadeEdges && layout == PageLayout.card ? 60 : 0,
      ),
    );
  }

  @protected
  Widget wrappedChild(
    BuildContext context,
    WidgetRef ref,
    int panels,
    StyleConfig style,
  ) {
    Widget wrapped = Container();
    final padding = PageContent.padding(
      context,
      ref,
      extend: extend,
      fadeEdges: fadeEdges,
      layout: layout,
      offsetBar: true,
    );

    if (child != null) {
      wrapped = scrollable
          ? SingleChildScrollView(
              padding: padding,
              child: child,
            )
          : Padding(
              padding: padding,
              child: child,
            );
    } else if (slivers != null) {
      wrapped = CustomScrollView(
        slivers: slivers!.map((item) {
          final index = extend ? 0 : slivers!.indexOf(item);
          return SliverPadding(
            padding: EdgeInsets.only(
              // only top padding on the first item
              top: index == 0 ? padding.top : itemSpacing / 2,
              left: padding.left,
              right: padding.right,
              // only bottom padding on the last item
              bottom: index == slivers!.length - 1
                  ? padding.bottom
                  : itemSpacing / 2,
            ),
            sliver: item,
          );
        }).toList(),
      );
    } else if (itemBuilder != null && query != null) {
      wrapped = PaginatedListView(
        query: query!,
        itemBuilder: itemBuilder!,
        padding: padding,
        itemSpacing: itemSpacing,
        leadingItems: leadingItems,
      );
    }

    return wrapped;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panels = ref.watch(panelsProvider);
    final style = ref.watch(styleConfigProvider);
    final padding = PageContent.padding(
      context,
      ref,
      extend: extend,
      fadeEdges: fadeEdges,
      layout: layout,
      offsetBar: false,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: maxWidth + padding.horizontal,
              maxWidth: maxWidth + padding.horizontal,
              maxHeight: size.height,
            ),
            child: wrappedChild(
              context,
              ref,
              panels,
              style,
            ),
          ),
        );
      },
    );
  }
}

typedef PageContentBuilder = PageContent Function(
  BuildContext context,
  WidgetRef ref,
  bool landscape,
);
