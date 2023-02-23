import 'package:zero_flutter/zero_flutter.dart';

class SwitchInput extends InputField<bool> {
  const SwitchInput(
    BuildContext context, {
    super.key,

    // InputField specific
    required super.id,
    super.validator,
    super.errorBuilder,
    super.alignment = InputFieldAlignment.start,
    super.dense = false,
    super.padding = const EdgeInsets.all(12),
    super.fillColor,
    super.leading,
    super.trailing,
    super.enabled = true,
    super.label,
    super.sanitizer,
  });

  @override
  bool defaultValue() {
    return false;
  }

  @override
  InputFieldState<bool, SwitchInput> createState() {
    return _SwtichInputState();
  }
}

class _SwtichInputState extends InputFieldState<bool, SwitchInput> {
  @override
  Widget fieldBuilder(
    BuildContext context, {
    required InputState<bool> state,
    required FocusNode focusNode,
  }) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.transparent,
        ),
        child: Switch(
          focusNode: fieldFocusNode,
          value: state.value,
          onChanged: (value) {
            widget
                .effectiveController(context)
                ?.updateValue<bool>(widget.id, value);
          },
          activeColor: Colors.success,
          inactiveTrackColor: Colors.transparent,
          inactiveThumbColor: colors.secondary,
          splashRadius: 0,
        ),
      ),
    );
  }
}
