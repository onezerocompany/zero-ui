import 'package:zero_flutter/zero_flutter.dart';

export 'form_controller.dart';
export 'form_buttons.dart';
export 'input_field.dart';

class InputForm extends HookConsumerWidget {
  const InputForm({
    super.key,
    required this.builder,
    this.onSaved,
    this.saveButtonPosition = FormButtonsPosition.none,
    this.canUndo = true,
    this.canAlwaysSave = false,
    this.saveLabel,
  });

  final Function(Map<String, dynamic> values, Function() saved)? onSaved;

  final FormButtonsPosition saveButtonPosition;
  final bool canUndo;
  final bool canAlwaysSave;
  final String? saveLabel;

  final Widget Function(
    BuildContext context,
    FormController controller,
  ) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useMemoized(
      () => FormController(
        onSaved: onSaved,
      ),
    );
    useListenable(controller);

    final buttons = AnimatedHider(
      visible: controller.dirty || canAlwaysSave,
      child: FormButtons(
        controller: controller,
        canUndo: canUndo,
        canAlwaysSave: canAlwaysSave,
        saveLabel: saveLabel,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (saveButtonPosition == FormButtonsPosition.top ||
            saveButtonPosition == FormButtonsPosition.topAndBottom)
          Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: buttons,
          ),
        builder(
          context,
          controller,
        ),
        if (saveButtonPosition == FormButtonsPosition.bottom ||
            saveButtonPosition == FormButtonsPosition.topAndBottom)
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: buttons,
          ),
      ],
    );
  }
}
