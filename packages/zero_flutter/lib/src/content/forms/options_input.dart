import 'package:flutter/services.dart';
import 'package:zero_flutter/zero_flutter.dart';

class OptionsInput<ValueType> extends InputField<ValueType> {
  const OptionsInput(
    super.state, {
    super.key,

    // InputField specific
    super.errorBuilder,
    super.alignment = InputFieldAlignment.center,
    super.dense = false,
    super.padding = const EdgeInsets.all(16),
    super.fillColor,
    super.leading,
    super.trailing,
    super.enabled = true,
    super.label,

    // OptionsInput specific
    required this.options,
    this.selectLabel = 'Select an option',
  });

  final List<InputOption<ValueType>> options;
  final String selectLabel;

  @override
  Widget fieldBuilder(
    BuildContext context,
    WidgetRef ref, {
    required InputState<ValueType> state,
    required FocusNode focusNode,
  }) {
    final mounted = useIsMounted();
    final colors = Theme.of(context).colorScheme;

    final valueTheme = TextButton.defaultConfig.copyWith(
      paddings: const {ButtonSize.medium: EdgeInsets.only(bottom: 2, top: 1)},
      fillColor: colors.secondary,
      contentColor: colors.onBackground,
      hoverBackground: false,
    );

    InputOption? currentOption = options.firstWhereOrNull(
      (option) => option.value == state.value,
    );

    showPicker() async {
      final selected = await OptionsDialog.show<ValueType>(
        currentValue: currentOption?.value,
        options: options,
      );
      if (mounted() && selected != null) {
        state.value = selected.value;
      }
    }

    return Focus(
      focusNode: focusNode,
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.enter) {
          showPicker();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: TextButton(
        config: valueTheme,
        text: currentOption?.label ?? selectLabel,
        onPressed: showPicker,
      ),
    );
  }
}
