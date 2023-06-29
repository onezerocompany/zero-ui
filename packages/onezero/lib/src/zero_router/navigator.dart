import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:onezero/onezero.dart';

enum ZeroNavigatorItemType {
  padding,
  page,
}

class ZeroNavigatorItem {
  ZeroNavigatorItem({
    required this.type,
    this.page,
    this.width = 0,
    this.collapsed = false,
  }) : assert(type != ZeroNavigatorItemType.page || page != null);

  final ZeroNavigatorItemType type;
  final ZeroPage? page;
  final bool collapsed;
  double width;

  double get leftover {
    if (type == ZeroNavigatorItemType.padding) {
      return 0;
    } else {
      return (page?.maxWidth ?? double.infinity) - width;
    }
  }

  Widget build(BuildContext context) {
    if (type == ZeroNavigatorItemType.padding) {
      return SizedBox(width: width);
    } else if (type == ZeroNavigatorItemType.page) {
      return SizedBox(
        width: width,
        child: page!.buildPage(context),
      );
    }
    return const SizedBox.shrink();
  }
}

class ZeroNavigator extends StatelessWidget {
  const ZeroNavigator({
    Key? key,
    required this.pages,
    this.padding = 14,
  }) : super(key: key);

  final List<ZeroPage> pages;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final theme = ZeroTheme.of(context);
    return Container(
      color: theme.colors.scaffold.surface.resolve(context),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final rowItems = items(constraints.maxWidth, padding, pages)
              .map((item) => item.build(context))
              .toList();
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: rowItems.length > 1 ? padding : 0),
            child: OverflowBox(
              maxWidth: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: rowItems,
              ),
            ),
          );
        },
      ),
    );
  }

  List<ZeroNavigatorItem> items(
    double screenWidth,
    double padding,
    List<ZeroPage> pages,
  ) {
    List<ZeroNavigatorItem> items = [
      ZeroNavigatorItem(
        type: ZeroNavigatorItemType.padding,
        width: padding,
      )
    ];

    // fill initially with the pages and add padding between
    double addedMinWidth = padding;
    for (var page in pages.reversed) {
      final fitsRegular = addedMinWidth + page.minWidth + padding < screenWidth;

      final fitsCollapsed =
          addedMinWidth + (page.collapsedWidth ?? page.minWidth) + padding <
              screenWidth;

      if (fitsRegular) {
        addedMinWidth += page.minWidth + padding;

        items.add(ZeroNavigatorItem(
          type: ZeroNavigatorItemType.page,
          page: page,
          width: page.minWidth,
        ));
        items.add(
          ZeroNavigatorItem(
            type: ZeroNavigatorItemType.padding,
            width: padding,
          ),
        );
      } else if (fitsCollapsed) {
        addedMinWidth += (page.collapsedWidth ?? page.minWidth) + padding;

        items.add(ZeroNavigatorItem(
          type: ZeroNavigatorItemType.page,
          page: page,
          collapsed: true,
          width: page.collapsedWidth ?? page.minWidth,
        ));
        items.add(
          ZeroNavigatorItem(
            type: ZeroNavigatorItemType.padding,
            width: padding,
          ),
        );
      } else {
        break;
      }
    }

    items = items.reversed.toList();

    int run = 0;
    while (true) {
      run++;
      double totalLeftover = 0;
      double totalWidth = 0;
      int count = 0;
      double smallest = double.infinity;
      for (var i = 0; i < items.length; i++) {
        final item = items[i];
        totalWidth += item.width;
        if (item.leftover > 0 && !item.collapsed) {
          totalLeftover += item.leftover;
          if (item.leftover < smallest) {
            smallest = item.leftover;
          }
          count++;
        }
      }

      final screenLeftover = screenWidth - totalWidth;
      final screenLeftOverperItem = screenLeftover / count;

      // if total leftover is less than 1, we are done
      if (totalLeftover < 1 || screenLeftover < 1 || run > 10) break;

      final limitedLeftoverPerItem = min(screenLeftOverperItem, smallest);
      final leftoverPerItem =
          clampDouble(totalLeftover / count, 0, limitedLeftoverPerItem);
      for (var i = 0; i < items.length; i++) {
        final item = items[i];
        if (item.leftover > 0 && !item.collapsed) {
          item.width += leftoverPerItem;
        }
      }
    }

    return items;
  }
}
