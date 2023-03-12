import 'package:zero_flutter/zero_flutter.dart';

enum FormButtonsPosition { top, bottom, topAndBottom, none }

class FormButtons extends ConsumerWidget {
  const FormButtons({
    super.key,
    required this.controller,
    this.canUndo = true,
  });

  final FormController controller;
  final bool canUndo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    final colors = Theme.of(context).colorScheme;
    return Section(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      itemSpacing: 16,
      children: [
        Button(
          config: Button.defaultConfig.copyWith(
            fillColor: Colors.success,
          ),
          leading: Icons.save,
          label: t.form.buttons.save,
          disabled: !controller.canSave,
          onPressed: controller.canSave ? controller.save : null,
        ),
        if (canUndo)
          IconButton(
            config: Button.defaultConfig.copyWith(
              fillColor: colors.background,
            ),
            icon: Icons.undo,
            disabled: !controller.dirty,
            onPressed: controller.reset,
          ),
      ],
    );
  }
}
