import 'package:zero_flutter/zero_flutter.dart';

class PageSearchProviderItem {
  PageSearchProviderItem({
    this.icon,
    this.name,
    this.description,
    required this.url,
    this.searchable = false,
  });

  final IconData? icon;
  final String? name;
  final String? description;
  final String url;
  final bool searchable;
}

class PageSearchProvider extends SearchProvider {
  PageSearchProvider(
    BuildContext context, {
    super.type = OmniSearchObject.page,
    super.fetchMechanisms = const [
      SearchFetchMechanism.recommend,
      SearchFetchMechanism.recent,
      SearchFetchMechanism.instant,
    ],
    required List<Page> pages,
  }) : pages = pages.expand((page) => fromPage(context, page, null)).toList();

  static Iterable<PageSearchProviderItem> fromPage(
    BuildContext context,
    Page page,
    Page? parent,
  ) {
    final metadata = page.metadata(context);
    return [
      if (metadata.searchable)
        PageSearchProviderItem(
          icon: metadata.icon,
          name: metadata.name?.call(context),
          description: metadata.description?.call(context),
          url: metadata.resolvedPath(
            context,
            parent: parent,
            fullPath: true,
          ),
        ),
      ...metadata.subpages.expand((child) => fromPage(context, child, page))
    ];
  }

  final List<PageSearchProviderItem> pages;

  @override
  Future<List<SearchResult>> recommend({
    int limit = 1000,
    int offset = 0,
  }) async {
    return pages
        .map(
          (page) => SearchResult(
            icon: page.icon,
            title: page.name ?? page.url,
            excerpt: page.description,
            url: page.url,
          ),
        )
        .toList();
  }

  @override
  Future<List<SearchResult>> query({
    required String query,
    int limit = 10,
    int offset = 0,
  }) async {
    List<SearchResult> results = pages
        .where((page) => page.searchable)
        .map(
          (page) => SearchResult(
            score: scoreObject(
              object: [
                page.name ?? "",
                page.url,
                page.description ?? "",
              ],
              query: query,
            ),
            title: page.name ?? page.url,
            excerpt: page.description,
            url: page.url,
          ),
        )
        .toList();

    results.sort((a, b) => b.score.compareTo(a.score));
    return results.sublist(offset * limit, (offset + 1) * limit);
  }
}
