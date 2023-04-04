import 'package:zero_ui/globals.dart';
import 'package:zero_ui/zero_ui.dart';

export 'multi_state.dart';

class MultiPageScaffoldBuilder extends ConsumerWidget {
  const MultiPageScaffoldBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(
    BuildContext context,
    MultiScaffoldState state,
    Size size,
  ) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(currentRouterLevelProvider);
    final panels = ref.watch(panelsProvider);

    final currentState = MultiScaffoldState(
      multiPage: panels > 1 ? 1 : 0,
      showingSecondPage: level > 1 ? 1 : 0,
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return TweenAnimationBuilder<MultiScaffoldState>(
          duration: pageTransitionDuration,
          curve: pageTransitionCurve,
          tween: Tween<MultiScaffoldState>(
            begin: currentState,
            end: currentState,
          ),
          builder: (
            BuildContext context,
            MultiScaffoldState currentState,
            Widget? child,
          ) {
            return builder(
              context,
              currentState,
              constraints.biggest,
            );
          },
        );
      },
    );
  }
}
