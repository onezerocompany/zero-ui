import 'package:flutter/widgets.dart';

// Pages are containers for items in a list.
// Pages should be instantiated with a certain size but can grow or shrink
// depending on the size of the list (insertions, deletions, etc).
class ListPage<Id, T> {
  ListPage({
    required this.items,
    required this.index,
    required this.beginBoundary,
    required this.endBoundary,
  });

  List<T> items;
  int index;

  final Id beginBoundary;
  final Id endBoundary;
}

class PaginatedList<T> extends StatelessWidget {
  PaginatedList({
    super.key,
    required this.itemBuilder,
    required this.itemPageProvider,
    int? itemCount,
  }) : childrenDelegate = SliverChildBuilderDelegate(
          (context, index) {
            final itemPage = itemPageProvider(context);
            final item = itemPage.items[index];
            return itemBuilder(context, item);
          },
          childCount: itemCount,
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
          addSemanticIndexes: true,
        );

  final SliverChildBuilderDelegate childrenDelegate;
  final Widget Function(BuildContext, T) itemBuilder;
  final ListPage Function(BuildContext) itemPageProvider;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          sliver: SliverList(
            delegate: childrenDelegate,
          ),
        ),
      ],
    );
  }
}
