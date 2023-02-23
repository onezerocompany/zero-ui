import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_flutter/zero_flutter.dart';

// A widget that contains the actual content of the page
class PageContent extends ConsumerWidget {
  const PageContent({
    super.key,
    this.child,
    this.slivers,
    this.itemBuilder,
    this.itemSpacing = 12,
    this.itemCount = 0,
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

  final IndexedWidgetBuilder? itemBuilder;
  final double itemSpacing;
  final int itemCount;

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
    BuildContext context, {
    required bool extend,
    required bool fadeEdges,
    required PageLayout layout,
  }) {
    if (extend) return EdgeInsets.zero;
    final style = AppConfig.style(context);
    final breakpoint = AdaptiveContext.breakpoint(context);
    final contentPadding = style.contentPadding.value(breakpoint);
    final gutter = style.gutters.value(breakpoint);
    final fullscreen =
        layout == PageLayout.fullscreen || layout == PageLayout.fullscreenCard;
    final panels = AdaptiveContext.panels(context);
    final useGutter = fullscreen || (panels > 1 && layout != PageLayout.card);
    return EdgeInsets.only(
      top: max(
        (useGutter ? gutter : contentPadding) +
            MediaQuery.of(context).padding.top,
        fadeEdges && layout == PageLayout.card ? 60 : 0,
      ),
      left: (useGutter ? gutter : contentPadding) +
          MediaQuery.of(context).padding.left,
      right: (useGutter ? gutter : contentPadding) +
          MediaQuery.of(context).padding.right,
      bottom: max(
        (useGutter ? gutter : contentPadding) +
            MediaQuery.of(context).padding.bottom,
        fadeEdges && layout == PageLayout.card ? 60 : 0,
      ),
    );
  }

  @protected
  Widget wrappedChild(
    BuildContext context,
  ) {
    final padding = PageContent.padding(
      context,
      extend: extend,
      fadeEdges: fadeEdges,
      layout: layout,
    );

    Widget wrapped = Container();

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
      wrapped = ListView.separated(
        padding: padding,
        separatorBuilder: (context, index) => SizedBox(height: itemSpacing),
        itemCount: itemCount,
        itemBuilder: itemBuilder!,
      );
    }

    return wrapped;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = PageContent.padding(
      context,
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
            child: wrappedChild(context),
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
