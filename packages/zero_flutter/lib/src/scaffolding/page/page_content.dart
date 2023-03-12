import 'dart:math';

import 'package:zero_flutter/zero_flutter.dart';

// A widget that contains the actual content of the page
class PageContent extends ConsumerWidget {
  const PageContent({
    super.key,
    this.child,
    this.slivers,
    this.itemBuilder,
    this.itemSpacing = 12,
    this.itemCount,
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

  final NullableIndexedWidgetBuilder? itemBuilder;
  final double itemSpacing;
  final int? itemCount;

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
    IndexedWidgetBuilder? itemBuilder,
    double? itemSpacing,
    int? itemCount,
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
      itemSpacing: itemSpacing ?? this.itemSpacing,
      itemCount: itemCount ?? this.itemCount,
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
        (useGutter ? gutters : contentPadding.bottom) + safeAreaInsets.bottom,
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
          final index = extend ? slivers : slivers!.indexOf(item);
          return SliverPadding(
            padding: EdgeInsets.only(
              // only top padding on the first item
              top: index == 0 ? padding.top : 0,
              left: padding.left,
              right: padding.right,
              // only bottom padding on the last item
              bottom: index == slivers!.length - 1 ? padding.bottom : 0,
            ),
            sliver: item,
          );
        }).toList(),
      );
    } else if (itemBuilder != null) {
      wrapped = ListView.builder(
        padding: padding,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final item = itemBuilder!(context, index);
          return Padding(
            padding: EdgeInsets.only(
              bottom: itemSpacing,
            ),
            child: item,
          );
        },
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
