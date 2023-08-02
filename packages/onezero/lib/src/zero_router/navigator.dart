import 'dart:math';
import 'dart:ui';

import 'package:onezero/onezero.dart';
import 'package:onezero/src/components/dot_paper.dart';

const double defaultGridUnit = 22;
const double defaultDotSize = 1;

enum ZeroNavigatorItemType {
  padding,
  page,
}

double clampDoubleToGrid(
  double value, {
  int steps = 2,
  double dotSize = defaultDotSize,
  double gridUnit = defaultGridUnit,
}) {
  assert(value >= 0, 'value must be greater than or equal to 0');
  assert(steps > 0, 'steps must be greater than 0');
  assert(dotSize > 0, 'dotSize must be greater than 0');
  assert(gridUnit > 0, 'gridUnit must be greater than 0');
  final stepCount = value > 0 ? (value / (gridUnit * steps)).floor() : 0;
  return stepCount >= 1 ? (stepCount * (gridUnit * steps) + (dotSize * 2)) : 0;
}

Size clampSizeToGrid(
  Size size, {
  int steps = 2,
  double dotSize = defaultDotSize,
  double gridUnit = defaultGridUnit,
}) {
  final width = clampDoubleToGrid(
    size.width,
    steps: steps,
    dotSize: dotSize,
    gridUnit: gridUnit,
  );
  final height = clampDoubleToGrid(
    size.height,
    steps: steps,
    dotSize: dotSize,
    gridUnit: gridUnit,
  );
  return Size(width, height);
}

class ZeroNavigatorItem {
  ZeroNavigatorItem({
    required this.type,
    this.page,
    this.size = Size.zero,
    this.gridUnit = defaultGridUnit,
    this.collapsed = false,
  }) : assert(type != ZeroNavigatorItemType.page || page != null);

  final ZeroNavigatorItemType type;
  final ZeroPage? page;
  final bool collapsed;
  final double gridUnit;
  Size size;

  double get leftoverWidth {
    if (type == ZeroNavigatorItemType.padding) {
      return 0;
    } else {
      return page?.maxWidth != null
          ? clampDoubleToGrid(page!.maxWidth - size.width)
          : double.infinity;
    }
  }

  Widget build(BuildContext context) {
    if (type == ZeroNavigatorItemType.padding) {
      return SizedBox(
        width: size.width,
        height: size.height,
      );
    } else if (type == ZeroNavigatorItemType.page) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        width: size.width,
        height: size.height,
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
    this.gridUnit = defaultGridUnit,
  }) : super(key: key);

  final List<ZeroPage> pages;
  final double gridUnit;

  @override
  Widget build(BuildContext context) {
    final theme = ZeroTheme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        const Overlay(),
        Container(
          color: theme.colors.scaffold.surface.resolve(context),
          child: Column(
            children: [
              NavigatorHeader(
                theme: theme,
                gridUnit: gridUnit,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final screenSize = Size(
                      clampDoubleToGrid(constraints.maxWidth, steps: 2),
                      clampDoubleToGrid(
                        constraints.maxHeight - gridUnit,
                        steps: 1,
                      ),
                    );

                    final rowItems = items(
                      screenSize: screenSize,
                      pages: pages,
                    ).map((item) => item.build(context)).toList();

                    return SizedBox(
                      height: screenSize.height,
                      width: screenSize.width,
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          DotPaper(
                            color: theme.colors.scaffold.content,
                            dotSpacing: gridUnit,
                            dotRadius: defaultDotSize,
                          ),
                          OverflowBox(
                            maxWidth: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: rowItems,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<ZeroNavigatorItem> items({
    required Size screenSize,
    required List<ZeroPage> pages,
  }) {
    List<ZeroNavigatorItem> items = [];

    // fill initially with the pages and add padding between
    double addedMinWidth = gridUnit;
    for (var page in pages.reversed) {
      final fitsRegular =
          addedMinWidth + page.minWidth + gridUnit < screenSize.width;
      final fitsCollapsed =
          addedMinWidth + (page.collapsedWidth ?? page.minWidth) + gridUnit <
              screenSize.width;

      if (fitsRegular || fitsCollapsed) {
        final pageWidth = clampDoubleToGrid(
          fitsRegular ? page.minWidth : (page.collapsedWidth ?? page.minWidth),
          gridUnit: gridUnit,
          steps: 1,
        );

        if (items.isNotEmpty) {
          items.add(
            ZeroNavigatorItem(
              type: ZeroNavigatorItemType.padding,
              gridUnit: gridUnit,
              size: Size(gridUnit - (defaultDotSize * 2), 10),
            ),
          );
        }

        addedMinWidth += pageWidth;
        items.add(
          ZeroNavigatorItem(
            type: ZeroNavigatorItemType.page,
            page: page,
            gridUnit: gridUnit,
            size: Size(
              pageWidth,
              screenSize.height,
            ),
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
        totalWidth += item.size.width;
        if (item.leftoverWidth > 0 && !item.collapsed) {
          totalLeftover += item.leftoverWidth;
          if (item.leftoverWidth < smallest) {
            smallest = item.leftoverWidth;
          }
          count++;
        }
      }

      final screenLeftover = max(0, screenSize.width - totalWidth);
      final screenLeftOverperItem = screenLeftover / max(1, count);
      final double limitedLeftoverPerItem = min(
        screenLeftOverperItem,
        smallest != double.infinity ? smallest : 0,
      );

      final leftoverPerItem =
          clampDouble(totalLeftover / count, 0, limitedLeftoverPerItem);

      // if total leftover is less than 1, we are done
      if (leftoverPerItem < gridUnit || run > 10) {
        break;
      }

      for (var i = 0; i < items.length; i++) {
        final item = items[i];
        if (item.leftoverWidth > 0 && !item.collapsed) {
          Size size = Size(
            clampDoubleToGrid(
              item.size.width + leftoverPerItem,
              steps: 2,
            ),
            item.size.height,
          );

          item.size = size;
        }
      }

      final paddingCount = items
          .where((item) => item.type == ZeroNavigatorItemType.padding)
          .length;
      if (paddingCount % 2 == 1) {
        // remove one grid unit from the first page item
        final lastPageItem = items.firstWhere(
          (item) => item.type == ZeroNavigatorItemType.page,
        );
        lastPageItem.size = Size(
          lastPageItem.size.width - gridUnit,
          lastPageItem.size.height,
        );
      }
    }

    return items;
  }
}

class NavigatorHeader extends StatelessWidget {
  const NavigatorHeader({
    super.key,
    required this.theme,
    required this.gridUnit,
  });

  final ZeroTheme theme;
  final double gridUnit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.only(
          top: gridUnit,
          left: gridUnit,
          right: gridUnit,
          bottom: gridUnit * 1.2,
        ),
        child: Row(
          children: [
            Text(
              "OneZero",
              style: theme.typography.display.medium.copyWith(
                weight: 100,
              ),
            ),
            SizedBox(width: gridUnit),
            const Expanded(child: NavigationBar()),
            SizedBox(width: gridUnit),
            Button(
              icon: Symbols.settings,
              color: theme.colors.page.surface,
            ),
            const SizedBox(width: 12),
            Button(
              icon: Symbols.notifications_rounded,
              color: theme.colors.page.surface,
            ),
            const SizedBox(width: 12),
            Button(
              icon: Symbols.person,
              color: theme.colors.page.surface,
            ),
          ],
        ),
      ),
    );
  }
}
