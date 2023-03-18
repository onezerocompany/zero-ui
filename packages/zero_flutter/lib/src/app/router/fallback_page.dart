import 'package:go_router/go_router.dart';
import 'package:zero_flutter/zero_flutter.dart';

class FallbackPage extends Page {
  const FallbackPage(
    super.state, {
    super.key,
    required super.metadata,
  });

  @override
  TopBarBuilder? get topBarBuilder => ((context, ref) {
        return const TopBar(
          title: "Not Found",
        );
      });

  @override
  PageContentBuilder? get contentBuilder => ((context, ref, landscape) {
        return PageContent(
          child: Center(
            child: Column(
              children: [
                Text(
                  'Hmm, where did this page go?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'This page doesn\'t exist.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 22),
                TextButton(
                  label: "Go Back",
                  leading: Icons.arrow_back,
                  onPressed: () => GoRouter.of(context).go("/"),
                ),
              ],
            ),
          ),
        );
      });
}
