import 'package:zero_flutter/zero_flutter.dart';

class SaveButtons extends ConsumerWidget {
  const SaveButtons({
    super.key,
    required this.controller,
    required this.dirty,
    required this.valid,
    this.showUndo = true,
  });

  final FormController controller;
  final bool dirty;
  final bool valid;
  final bool showUndo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    return Section(
      itemSpacing: 16,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Button(
          leading: Icons.save,
          disabled: !valid,
          config: Button.defaultConfig.copyWith(
            size: ButtonSize.medium,
            fillWidth: true,
          ),
          label: t.form.buttons.save,
          onPressed: controller.save,
        ),
        if (showUndo)
          Button(
            config: Button.defaultConfig.copyWith(
              size: ButtonSize.small,
              fillColor: Theme.of(context).colorScheme.background,
            ),
            leading: Icons.undo,
            label: t.form.buttons.undo,
            onPressed: controller.reset,
          ),
      ],
    );
  }
}
