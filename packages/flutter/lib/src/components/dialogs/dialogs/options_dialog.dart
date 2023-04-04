import 'package:zero_ui/zero_ui.dart';

class OptionsDialog<ValueType> extends StatefulWidget {
  const OptionsDialog({
    super.key,
    required this.options,
    required this.currentValue,
    required this.itemBuilder,
  });

  final List<ValueType> options;
  final Widget? Function(
    OptionState<ValueType> state,
  )? itemBuilder;
  final dynamic currentValue;

  static Future<ValueType?> show<ValueType>({
    required List<ValueType> options,
    required dynamic currentValue,
    required Widget? Function(
      OptionState<ValueType> state,
    )?
        optionBuilder,
  }) async {
    return await showDialog(
      OptionsDialog<ValueType>(
        options: options,
        currentValue: currentValue,
        itemBuilder: optionBuilder,
      ),
    );
  }

  @override
  State<OptionsDialog<ValueType>> createState() =>
      _OptionsDialogState<ValueType>();
}

class _OptionsDialogState<ValueType> extends State<OptionsDialog<ValueType>> {
  int currentIndex = -1;

  @override
  initState() {
    super.initState();
    currentIndex = widget.options.indexWhere(
      (option) => option == widget.currentValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      onConfirm: () => Navigator.of(context).pop(
        currentIndex == -1 ? null : widget.options[currentIndex],
      ),
      onDismiss: () => Navigator.of(context).pop(),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 26,
          vertical: 26,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index >= widget.options.length) return null;

          final option = widget.options[index];

          final state = OptionState<ValueType>(
            value: option,
            selected: currentIndex == index,
            current: false,
            templateButtonConfig: OptionsInput.templateButtonConfig(
              context,
              currentIndex == index,
              false,
            ),
            pressed: () {
              setState(() {
                currentIndex = index;
              });
            },
          );

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: widget.itemBuilder?.call(state) ??
                Button(
                  onPressed: state.pressed,
                  label: state.value.toString(),
                  config: state.templateButtonConfig,
                ),
          );
        },
      ),
    );
  }
}
