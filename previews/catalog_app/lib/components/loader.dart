import 'package:zero_ui/zero_ui.dart';

final loaderProgress = StateProvider.autoDispose<double>((ref) => 0.5);

PageMetadata loaderPageMetadata(Locale locale) {
  return const PageMetadata(
    path: "/loader",
    icon: Icons.percent,
    name: "Loader",
    description: "A circular loader with a progress indicator",
  );
}

class LoaderPage extends Page {
  const LoaderPage(
    super.state, {
    super.metadata = loaderPageMetadata,
    super.key,
    super.layout = PageLayout.card,
  });

  @override
  PageContentBuilder? get contentBuilder => (context, ref, landscape) {
        final progress = ref.watch(loaderProgress);
        return PageContent(
            child: Column(
          children: [
            const Loader(
              size: 48,
            ),
            const SizedBox(height: 24),
            const Loader(
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            Loader(
              size: 48,
              progress: progress,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(icon: Icons.remove),
                  onPressed: () {
                    ref.read(loaderProgress.notifier).state -= 0.1;
                  },
                  config: IconButton.defaultConfig.copyWith(
                    transparency: 1,
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(icon: Icons.add),
                  onPressed: () {
                    ref.read(loaderProgress.notifier).state += 0.1;
                  },
                  config: IconButton.defaultConfig.copyWith(
                    transparency: 1,
                  ),
                ),
              ],
            )
          ],
        ));
      };
}
