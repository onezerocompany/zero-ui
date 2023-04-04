import 'dart:async';

import 'package:flutter/services.dart';
import 'package:zero_ui/zero_ui.dart';

class OptionState<ValueType> {
  const OptionState({
    required this.value,
    required this.current,
    required this.selected,
    required this.pressed,
    required this.templateButtonConfig,
  });

  final ValueType? value;
  final bool current;
  final bool selected;
  final ButtonConfig templateButtonConfig;
  final Function() pressed;
}

class OptionsInput<ValueType> extends InputField<ValueType> {
  const OptionsInput(
    super.state, {
    super.key,

    // InputField specific
    super.errorBuilder,
    super.alignment = InputFieldAlignment.end,
    super.dense = false,
    super.padding = const EdgeInsets.only(
      top: 12,
      bottom: 12,
      left: 24,
      right: 12,
    ),
    super.fillColor,
    super.leading,
    super.trailing,
    super.enabled = true,
    super.label,

    // OptionsInput specific
    required this.options,
    this.optionBuilder,
    this.selectLabel,
  });

  final FutureOr<List<ValueType>> Function() options;
  final Widget? Function(
    OptionState<ValueType> state,
  )? optionBuilder;

  final String? selectLabel;

  static ButtonConfig templateButtonConfig<ValueType>(
    BuildContext context,
    bool selected,
    bool current,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    return Button.defaultConfig.copyWith(
      fillColor: selected ? colors.primary : colors.background,
      borderColor: selected ? colors.primary : Colors.transparent,
      contentColor: selected
          ? (isDark ? colors.onBackground : colors.primary)
          : colors.onBackground,
      borderWidth: 2,
      transparency: selected ? (isDark ? 0.8 : 0.9) : 0.4,
      states: {
        ...Button.defaultConfig.states,
        if (current)
          ButtonState.disabled: const ButtonStateConfig(
            brightness: 1,
            opacity: 1,
            scale: 1,
          ),
      },
    );
  }

  @override
  Widget fieldBuilder(
    BuildContext context,
    WidgetRef ref, {
    required InputState<ValueType> state,
    required FocusNode focusNode,
  }) {
    final mounted = useIsMounted();

    showPicker() async {
      final loadedOptions = await options();
      final selected = await OptionsDialog.show<ValueType>(
        currentValue: state.value,
        options: loadedOptions,
        optionBuilder: optionBuilder,
      );
      if (mounted() && selected != null) {
        state.value = selected;
      }
    }

    final optionState = OptionState<ValueType>(
      value: state.value,
      selected: focusNode.hasFocus,
      current: true,
      pressed: showPicker,
      templateButtonConfig: templateButtonConfig<ValueType>(
        context,
        focusNode.hasFocus,
        true,
      ),
    );

    return Focus(
      focusNode: focusNode,
      canRequestFocus: enabled,
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.enter) {
          showPicker();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: optionBuilder?.call(optionState) ??
          Button(
            onPressed: showPicker,
            config: optionState.templateButtonConfig,
            label: selectLabel ??
                (state.value == null ? 'Select' : state.value.toString()),
          ),
    );
  }
}
