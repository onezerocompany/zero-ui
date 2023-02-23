import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_flutter/zero_flutter.dart';

// focus nodes
final omniScaffoldFocus = FocusNode();
final omniSearchFocus = FocusNode();

final omniBarOpen = StateProvider<bool>((ref) => false);
final omniSearching = StateProvider<bool>((ref) => false);
final omniBarQuery = StateProvider<String>((ref) => '');

final searchProviders = StateProvider<List<SearchProvider>>((ref) => []);
final omniRecommended = FutureProvider<List<SearchResult>>((ref) async {
  final providers = ref.watch(searchProviders);
  var recommended = <SearchResult>[];
  for (final provider in providers) {
    recommended.addAll(await provider.recommend());
  }
  return recommended;
});
