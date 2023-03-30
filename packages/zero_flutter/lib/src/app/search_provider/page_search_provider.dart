import 'package:zero_flutter/zero_flutter.dart';

class PageSearchProviderItem {
  PageSearchProviderItem({
    required this.icon,
    required this.name,
    required this.description,
    required this.url,
    required this.searchable,
    required this.hasAccess,
  });

  final IconData? icon;
  final String? name;
  final String? description;
  final String url;
  final bool searchable;
  final bool Function()? hasAccess;
}

class PageSearchProvider extends SearchProvider {
  PageSearchProvider({
    super.type = OmniSearchObject.page,
    super.fetchMechanisms = const [
      SearchFetchMechanism.recommend,
      SearchFetchMechanism.recent,
      SearchFetchMechanism.instant,
    ],
    required List<RouterEntry> entries,
    this.fillParameters,
  }) : entries = entries
            .expand(
              (entry) => fromEntry(
                entry,
                null,
              ),
            )
            .toList();

  static Iterable<PageSearchProviderItem> fromEntry(
    RouterEntry entry,
    RouterEntry? parent,
  ) {
    return [
      if (entry.metadata.searchable)
        PageSearchProviderItem(
          icon: entry.metadata.icon,
          name: entry.metadata.name.trim(),
          description: entry.metadata.description?.trim(),
          url: entry.fullPath,
          searchable: entry.metadata.searchable,
          hasAccess: entry.metadata.hasAccess,
        ),
      ...entry.subentries.expand(
        (subEntry) => fromEntry(
          subEntry,
          entry,
        ),
      )
    ];
  }

  final List<PageSearchProviderItem> entries;
  final String Function(String path)? fillParameters;

  @override
  Future<List<SearchResult>> recommend({
    int limit = 1000,
    int offset = 0,
  }) async {
    return entries
        .where((page) => page.searchable && page.hasAccess?.call() == true)
        .map(
          (page) => SearchResult(
            icon: page.icon,
            title: page.name ?? page.url,
            excerpt: page.description,
            url: fillParameters != null ? fillParameters!(page.url) : page.url,
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
    List<SearchResult> results = entries
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
