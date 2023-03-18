import 'package:zero_flutter/zero_flutter.dart';
import 'package:flutter/material.dart' as material;

part 'omni_search.g.dart';

final omniSearchFocus = FocusNode();

@riverpod
bool omniSearching(OmniSearchingRef ref) {
  return false;
}

@riverpod
String omniSearchQuery(OmniSearchQueryRef ref) {
  return '';
}

final omniRecommendations = FutureProvider<List<SearchResult>>((ref) async {
  final providers = ref.watch(omniConfigProvider).searchProviders;
  var recommended = <SearchResult>[];
  for (final provider in providers) {
    recommended.addAll(await provider.recommend());
  }
  return recommended;
});

class OmniSearch extends HookConsumerWidget {
  const OmniSearch({super.key});

  static const double height = 48;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    final query = ref.watch(omniSearchQueryProvider);
    final controller = useTextEditingController(text: query);

    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final searching = ref.watch(omniSearchingProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Focus(
      onFocusChange: (focus) {
        if (focus) {
          ref.read(omniBarStateProvider.notifier).setOpen(true);
        }
      },
      child: SizedBox(
        height: OmniSearch.height,
        child: Glass(
          state: searching ? GlassState.invisible : GlassState.translucent,
          color: isDark ? colors.surface : colors.background,
          transparency: 0.8,
          cornerRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                child: IconButton(
                  config: IconButton.defaultConfig.copyWith(
                    size: ButtonSize.small,
                    transparency: 1,
                  ),
                  icon: Icons.search,
                  onPressed: () {
                    omnibarFocus.requestFocus();
                  },
                ),
              ),
              Expanded(
                child: Focus(
                  onFocusChange: (focus) {
                    ref.read(omniBarStateProvider.notifier).setSearching(focus);
                  },
                  child: material.TextField(
                    clipBehavior: Clip.none,
                    focusNode: omniSearchFocus,
                    controller: controller,
                    enableSuggestions: true,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      border: InputBorder.none,
                      hintStyle: text.titleMedium?.copyWith(
                        color: colors.onSurface.withOpacity(0.5),
                        height: 1,
                        fontSize: 18,
                      ),
                      hintText: t.scaffold.search,
                    ),
                    cursorColor: colors.onSurface,
                    cursorHeight: 16,
                    maxLines: 1,
                    minLines: 1,
                    style: text.titleMedium?.copyWith(
                      color: colors.onSurface,
                      height: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) {
                      ref.read(omniBarStateProvider.notifier).setQuery(query);
                    },
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: searching ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 12.0,
                    left: 8.0,
                  ),
                  child: IconButton(
                    icon: Icons.clear,
                    config: IconButton.defaultConfig.copyWith(
                      size: ButtonSize.small,
                      transparency: 1,
                    ),
                    onPressed: () {
                      useEffect(
                        () => () {
                          ref.read(omniBarStateProvider.notifier).setQuery("");
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
