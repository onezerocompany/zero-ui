import 'package:zero_flutter/zero_flutter.dart';

class InputOption<ValueType> {
  final String label;
  final String? description;
  final dynamic icon;
  final ValueType value;

  const InputOption({
    required this.label,
    this.description,
    this.icon,
    required this.value,
  });
}

class OptionsDialog<ValueType> extends StatefulWidget {
  const OptionsDialog({
    super.key,
    required this.options,
    required this.currentValue,
  });

  final List<InputOption<ValueType>> options;
  final dynamic currentValue;

  static Future<InputOption<ValueType>?> show<ValueType>({
    required List<InputOption<ValueType>> options,
    required dynamic currentValue,
  }) async {
    return await showDialog(
      OptionsDialog<ValueType>(
        options: options,
        currentValue: currentValue,
      ),
    );
  }

  @override
  State<OptionsDialog> createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  int currentIndex = -1;

  @override
  initState() {
    super.initState();
    currentIndex = widget.options.indexWhere(
      (option) => option.value == widget.currentValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;

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
          // check if widget.options has this index
          // if not, return null
          if (index >= widget.options.length) return null;
          final option = widget.options[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: ListItem(
              config: ListItem.defaultConfig.copyWith(
                fillColor:
                    currentIndex == index ? colors.primary : colors.background,
                borderColor:
                    currentIndex == index ? colors.primary : Colors.transparent,
                contentColor: currentIndex == index
                    ? (isDark ? colors.onBackground : colors.primary)
                    : colors.onBackground,
                borderWidth: 2,
                transparency:
                    currentIndex == index ? (isDark ? 0.8 : 0.9) : 0.4,
              ),
              icon: option.icon,
              label: option.label,
              sublabel: option.description,
              onPressed: () {
                setState(
                  () => {
                    currentIndex = index,
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
