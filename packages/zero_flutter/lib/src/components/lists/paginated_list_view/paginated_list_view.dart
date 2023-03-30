import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zero_flutter/zero_flutter.dart';

import 'page_registry.dart';

class PaginatedListView extends HookWidget {
  final Query query;
  final Widget Function(DocumentSnapshot) itemBuilder;
  final bool listen;
  final int pageSize;
  final double itemSpacing;
  final EdgeInsets padding;
  final List<Widget>? leadingItems;

  const PaginatedListView({
    super.key,
    required this.query,
    required this.itemBuilder,
    this.listen = true,
    this.pageSize = 1000,
    this.itemSpacing = 12,
    this.padding = EdgeInsets.zero,
    this.leadingItems,
  });

  Widget? renderItem(
    PageRegistry registry,
    int index,
  ) {
    if (leadingItems != null && index < leadingItems!.length) {
      return leadingItems![index];
    }

    final queryIndex = index - (leadingItems?.length ?? 0);
    final pageIndex = queryIndex ~/ pageSize;
    final itemIndex = queryIndex % pageSize;
    final item = registry.itemFor(pageIndex, itemIndex);

    if (item.document != null) {
      return itemBuilder(item.document!);
    } else if (item.isLoading && itemIndex == 0) {
      return const Center(child: Loader());
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final registry = useMemoized(
      () => PageRegistry(
        query: query,
        listen: listen,
        pageSize: pageSize,
      ),
      [query],
    );
    useListenable(registry);
    // reload the registry when the query changes

    return ListView.builder(
      padding: padding,
      itemBuilder: (context, index) {
        final item = renderItem(registry, index);
        if (item == null) return null;
        return Padding(
          padding: EdgeInsets.only(
            top: index == 0 ? 0 : itemSpacing,
          ),
          child: item,
        );
      },
    );
  }
}
