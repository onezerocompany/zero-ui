import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';

class OmniResults extends ConsumerWidget {
  const OmniResults({
    super.key,
    required this.barHeight,
  });

  final double barHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final recommended = ref.watch(omniRecommended);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final panels = AdaptiveContext.panels(context);

    return Center(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: AnimatedContainer(
              duration: OmniBar.transitionDuration,
              curve: pageTransitionCurve,
              height:
                  panels > 1 ? barHeight : MediaQuery.of(context).padding.top,
            ),
          ),
          // create a sliver list of recommended results
          recommended.when(
            data: (items) {
              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final result = items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 500,
                            ),
                            child: ListItem(
                              disabled: result.url ==
                                  AppConfig.router(context).currentPath,
                              config: ListItem.defaultConfig.copyWith(
                                fillColor:
                                    isDark ? colors.surface : colors.background,
                                transparency: 0.3,
                              ),
                              icon: result.icon,
                              label: result.title,
                              sublabel: result.excerpt,
                              link: result.url,
                              onPressed: () {
                                ref.read(omniBarOpen.notifier).state = false;
                                omnibarFocus.unfocus();
                                omniScaffoldFocus.requestFocus();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: items.length,
                  ),
                ),
              );
            },
            loading: () {
              return const SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: Loader(),
                  ),
                ),
              );
            },
            error: (error, stack) {
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(error.toString()),
                  ),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: AnimatedContainer(
              duration: OmniBar.transitionDuration,
              curve: pageTransitionCurve,
              height: panels < 2
                  ? barHeight
                  : MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }
}
