import 'package:zero_flutter/zero_flutter.dart';

class CheckInput extends InputField<bool> {
  const CheckInput(
    super.state, {
    super.key,

    // InputField specific
    super.errorBuilder,
    super.alignment = InputFieldAlignment.end,
    super.dense = false,
    super.padding = const EdgeInsets.all(14),
    super.fillColor,
    super.leading,
    super.trailing,
    super.enabled = true,
    super.label,
  });

  @override
  Widget fieldBuilder(
    BuildContext context,
    WidgetRef ref, {
    required InputState<bool> state,
    required FocusNode focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: Transform.scale(
        scale: 1.4,
        child: Checkbox(
          focusNode: focusNode,
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
          onChanged: enabled
              ? (value) {
                  state.value = value ?? false;
                }
              : null,
        ),
      ),
    );
  }
}
