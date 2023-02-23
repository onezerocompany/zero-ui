import 'package:zero_flutter/zero_flutter.dart';

class CheckInput extends InputField<bool> {
  const CheckInput(
    BuildContext context, {
    super.key,

    // InputField specific
    required super.id,
    super.validator,
    super.errorBuilder,
    super.alignment = InputFieldAlignment.start,
    super.dense = false,
    super.padding = const EdgeInsets.all(10),
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
  InputFieldState<bool, CheckInput> createState() {
    return _CheckInputState();
  }
}

class _CheckInputState extends InputFieldState<bool, CheckInput> {
  @override
  Widget fieldBuilder(
    BuildContext context, {
    required InputState<bool> state,
    required FocusNode focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: Transform.scale(
        scale: 1.4,
        child: Checkbox(
          focusNode: fieldFocusNode,
          splashRadius: 0,
          activeColor: Theme.of(context).colorScheme.secondary,
          checkColor: Theme.of(context).colorScheme.background,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 1.5,
          ),
          value: state.value,
          onChanged: (value) {
            widget
                .effectiveController(context)
                ?.updateValue<bool>(widget.id, value ?? false);
          },
        ),
      ),
    );
  }
}
