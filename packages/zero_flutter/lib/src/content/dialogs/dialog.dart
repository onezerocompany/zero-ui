import 'package:zero_flutter/zero_flutter.dart';

export 'time_dialog.dart';
export 'date_dialog.dart';
export 'show_dialog.dart';
export 'options_dialog.dart';

class Dialog extends StatelessWidget {
  const Dialog({
    super.key,
    required this.child,
    this.canConfirm,
    required this.onDismiss,
    required this.onConfirm,
    this.confirmColor,
    this.confirmText,
  });

  final Widget child;
  final bool Function()? canConfirm;
  final VoidCallback? onConfirm;
  final VoidCallback? onDismiss;
  final Color? confirmColor;
  final String? confirmText;

  @override
  build(context) {
    return Center(
      child: AnimatedGlass(
        cornerRadius: AdaptiveValue.fixed(
          const BorderRadius.all(
            Radius.circular(22),
          ),
        ),
        state: GlassState.translucent,
        color: Theme.of(context).colorScheme.surface,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 500,
            maxWidth: 400,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: SingleChildScrollView(child: child)),
              SizedBox(
                child: AnimatedGlass(
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
                            label: confirmText ??
                                ZeroUIAppLocalizations.of(context)
                                    ?.confirmButton ??
                                "Confirm",
                            onPressed: onConfirm,
                            config: Button.defaultConfig.copyWith(
                              fillColor: confirmColor ??
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      TextButton(
                        text: "Cancel",
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
    );
  }
}
