import 'package:zero_flutter/zero_flutter.dart';

class SwitchInput extends InputField<bool> {
  const SwitchInput(
    super.state, {
    super.key,

    // InputField specific
    super.errorBuilder,
    super.alignment = InputFieldAlignment.end,
    super.dense = false,
    super.padding = const EdgeInsets.all(12),
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
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.transparent,
        ),
        child: Switch(
          focusNode: focusNode,
          value: state.value,
          onChanged: enabled ? (value) => state.value = value : null,
          activeColor: Colors.success,
          inactiveTrackColor: Colors.transparent,
          inactiveThumbColor: colors.secondary,
          splashRadius: 0,
        ),
      ),
    );
  }
}
