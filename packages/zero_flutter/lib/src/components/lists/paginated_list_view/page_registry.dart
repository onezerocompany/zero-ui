import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'page_stream.dart';

class PageRegistryItem {
  final bool isLast;
  final bool isLoading;
  final DocumentSnapshot? document;

  const PageRegistryItem({
    required this.isLast,
    required this.isLoading,
    required this.document,
  });
}

class PageRegistry extends ChangeNotifier {
  final Query query;
  final bool listen;
  final int pageSize;

  List<PageStream> pages = [];

  PageRegistry({
    required this.query,
    required this.listen,
    this.pageSize = 2,
  });

  PageRegistryItem itemFor(
    int pageIndex,
    int itemIndex,
  ) {
    if (pageIndex < pages.length) {
      final page = pages[pageIndex];
      return PageRegistryItem(
        isLast: page.isLastPage,
        isLoading: page.isLoading,
        document: page.documents.length > itemIndex
            ? page.documents[itemIndex]
            : null,
      );
    } else {
      loadMore();
      return const PageRegistryItem(
        isLast: true,
        isLoading: false,
        document: null,
      );
    }
  }

  void loadMore() {
    Future.delayed(Duration.zero, () {
      if (pages.isNotEmpty && pages.last.isLastPage) return;

      var pageQuery = query.limit(pageSize);
      if (pages.isNotEmpty) {
        final lastDocument = pages.last.lastDocument;
        if (lastDocument != null) {
          pageQuery = pageQuery.startAfterDocument(lastDocument);
        }
      }

      final pageStream = PageStream(
        listen ? pageQuery.snapshots() : pageQuery.get().asStream(),
        pageSize: pageSize,
      );

      pageStream.addListener(() {
        if (pageStream.needsReload) reload();
        notifyListeners();
      });
      pages.add(pageStream);
      notifyListeners();
    });
  }

  void reload() {
    Future.delayed(Duration.zero, () {
      for (var element in pages) {
        element.dispose();
      }
      pages = [];
      loadMore();
    });
  }
}
