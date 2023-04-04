import 'package:zero_ui/zero_ui.dart';

export 'search_result.dart';
export 'match_object.dart';
export 'page_search_provider.dart';

enum SearchFetchMechanism {
  /// Provides results before the user has typed anything
  recommend,

  /// Recently used results, should be cached
  recent,

  /// Searches while the user is typing and immediately returns results
  /// used for cheap (mostly local) searches
  instant,

  /// Searches when the user presses the search button
  /// used for expensive searches
  manual,
}

abstract class SearchProvider {
  const SearchProvider({
    this.priority = 0,
    required this.type,
    required this.fetchMechanisms,
  });

  final int priority;
  final OmniSearchObject type;
  final List<SearchFetchMechanism> fetchMechanisms;

  SearchResult manualPlaceholder(String query) {
    return SearchResult(
      icon: Icons.search,
      title: 'Search for $query',
    );
  }

  Future<List<SearchResult>> query({
    required String query,
    int limit = 10,
    int offset = 0,
  }) async {
    return [];
  }

  Future<List<SearchResult>> recommend({
    int limit = 5,
    int offset = 0,
  }) async {
    return [];
  }

  Future<List<SearchResult>> recent({
    int limit = 3,
    int offset = 0,
  }) async {
    return [];
  }
}
