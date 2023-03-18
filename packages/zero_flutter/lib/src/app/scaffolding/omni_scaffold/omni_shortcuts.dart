import 'package:flutter/services.dart';
import 'package:zero_flutter/zero_flutter.dart';

class ToggleOmnibarIntent extends Intent {
  const ToggleOmnibarIntent();
}

class CloseOmnibarIntent extends Intent {
  const CloseOmnibarIntent();
}

class OmniBarShortcuts extends ConsumerWidget {
  const OmniBarShortcuts({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Shortcuts(
      shortcuts: const {
        // k with ctrl toggles the omnibar
        SingleActivator(LogicalKeyboardKey.keyK, control: true):
            ToggleOmnibarIntent(),
        // ctrl + k toggles the omnibar
        SingleActivator(LogicalKeyboardKey.keyK, meta: true):
            ToggleOmnibarIntent(),
        // esc closes the omnibar
        SingleActivator(LogicalKeyboardKey.escape): CloseOmnibarIntent(),
      },
      child: Actions(
        actions: {
          ToggleOmnibarIntent: CallbackAction<ToggleOmnibarIntent>(
            onInvoke: (intent) {
              ref.read(omniBarStateProvider.notifier).toggleOpen();
              return null;
            },
          ),
          CloseOmnibarIntent: CallbackAction<CloseOmnibarIntent>(
            onInvoke: (intent) {
              ref.read(omniBarStateProvider.notifier).setOpen(false);
              return null;
            },
          ),
        },
        child: Focus(
          focusNode: omniScaffoldFocus,
          autofocus: true,
          canRequestFocus: true,
          skipTraversal: true,
          child: child,
        ),
      ),
    );
  }
}
