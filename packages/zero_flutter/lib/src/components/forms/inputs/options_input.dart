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
    required this.currentLabel,
    this.selectLabel = 'Select an option',
  });

  final Future<List<InputOption<ValueType>>> Function() options;
  final String Function(ValueType) currentLabel;
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

    String? selectedLabel = currentLabel(state.value);

    showPicker() async {
      final renderedOptions = await options();
      final selected = await OptionsDialog.show<ValueType>(
        currentValue: state.value,
        options: renderedOptions,
      );
      if (mounted() && selected != null) {
        state.value = selected.value;
        selectedLabel = selected.label;
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
        enabled: enabled,
        config: valueTheme,
        label: selectedLabel ?? selectLabel,
        onPressed: showPicker,
      ),
    );
  }
}
