import 'package:zero_flutter/zero_flutter.dart';

class Dialog extends ConsumerWidget {
  const Dialog({
    super.key,
    required this.child,
    this.canConfirm,
    required this.onDismiss,
    required this.onConfirm,
    this.confirmColor,
    this.confirmText,
    this.confirmLoading = false,
  });

  final Widget child;
  final bool Function()? canConfirm;
  final VoidCallback? onConfirm;
  final VoidCallback? onDismiss;
  final Color? confirmColor;
  final String? confirmText;
  final bool confirmLoading;

  @override
  build(context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Glass(
          cornerRadius: BorderRadius.circular(22),
          state: GlassState.translucent,
          color: Theme.of(context).colorScheme.surface,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
              maxHeight: 600,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: child,
                ),
                SizedBox(
                  child: Glass(
                    state: GlassState.translucent,
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (canConfirm?.call() ?? true)
                          Padding(
                            padding: const EdgeInsets.only(right: 22.0),
                            child: Button(
                              leading: Icons.check,
                              label: confirmText ?? t.scaffold.dialogs.confirm,
                              onPressed: onConfirm,
                              loading: confirmLoading,
                              config: Button.defaultConfig.copyWith(
                                fillColor: confirmColor ??
                                    Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        TextButton(
                          label: "Cancel",
                          onPressed: onDismiss,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
