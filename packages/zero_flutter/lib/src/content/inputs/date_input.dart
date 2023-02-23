import 'package:intl/intl.dart';
import 'package:zero_flutter/zero_flutter.dart';

class DateInput extends InputField<DateTime> {
  const DateInput(
    BuildContext context, {
    super.key,

    // InputField specific
    required super.id,
    super.validator,
    super.errorBuilder,
    super.alignment = InputFieldAlignment.center,
    super.dense = false,
    super.padding = const EdgeInsets.all(16),
    super.fillColor,
    super.leading,
    super.trailing,
    super.enabled = true,
    super.label,
    super.sanitizer,

    // DateInput specific
    this.ranged = false,
  });

  final bool ranged;

  @override
  DateTime defaultValue() {
    return DateTime.now();
  }

  @override
  InputFieldState<DateTime, DateInput> createState() {
    return _DateInputState();
  }
}

class _DateInputState extends InputFieldState<DateTime, DateInput> {
  @override
  Widget fieldBuilder(
    BuildContext context, {
    required InputState<DateTime> state,
    required FocusNode focusNode,
  }) {
    final date = state.value;
    final colors = Theme.of(context).colorScheme;

    final valueTheme = TextButton.defaultConfig.copyWith(
      paddings: {ButtonSize.medium: EdgeInsets.zero},
      hoverBackground: false,
      transparency: 1,
    );
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.start,
      children: [
        TextButton(
          config: valueTheme,
          // show current date as a local date
          text: DateFormat(
            "EE, dd MMM yyyy",
            "nl",
          ).format(date),
          onPressed: () async {
            DateTime? newDate = await DateDialog.show(
              initialDate: state.value,
            );
            if (newDate != null && mounted) {
              widget
                  .effectiveController(context)
                  ?.updateValue<DateTime>(widget.id, newDate);
            }
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "at",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onBackground.withOpacity(0.6),
                  ),
            ),
            const SizedBox(width: 4),
            TextButton(
              config: valueTheme,
              // show current date as a local date
              text: "${DateFormat(
                "h:mm",
                "nl",
              ).format(date)}${MediaQuery.of(context).alwaysUse24HourFormat ? "" : date.hour >= 12 ? " PM" : " AM"}",
              onPressed: () async {
                DateTime? newDate = await TimeDialog.show(
                  initialDate: date,
                  is24h: MediaQuery.of(context).alwaysUse24HourFormat,
                );
                if (newDate != null && mounted) {
                  widget
                      .effectiveController(context)
                      ?.updateValue<DateTime>(widget.id, newDate);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
