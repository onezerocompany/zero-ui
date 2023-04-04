import 'package:zero_ui/zero_ui.dart';

enum FormButtonsPosition { top, bottom, topAndBottom, none }

class FormButtons extends ConsumerWidget {
  const FormButtons({
    super.key,
    required this.controller,
    this.canUndo = true,
    this.saveLabel,
    this.canAlwaysSave = false,
  });

  final FormController controller;
  final bool canUndo;
  final bool canAlwaysSave;
  final String? saveLabel;

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
          label: saveLabel ?? t.forms.buttons.save,
          enabled: controller.canSave || canAlwaysSave,
          onPressed: controller.canSave ? controller.save : null,
        ),
        if (canUndo)
          IconButton(
            config: Button.defaultConfig.copyWith(
              fillColor: colors.background,
            ),
            icon: Icons.undo,
            enabled: controller.dirty,
            onPressed: controller.reset,
          ),
      ],
    );
  }
}
