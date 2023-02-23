import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';

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
    Widget? child,
  ) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = AppConfig.router(context).level;
    final panels = AdaptiveContext.panels(context);

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
              null,
            );
          },
          child: const Scaffold(
            body: Center(
              child: Text("Hello World"),
            ),
          ),
        );
      },
    );
  }
}
