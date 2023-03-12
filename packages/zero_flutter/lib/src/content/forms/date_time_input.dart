import 'package:flutter/services.dart';
import 'package:zero_flutter/src/content/buttons/blank_button.dart';
import 'package:zero_flutter/zero_flutter.dart';
import 'package:intl/intl.dart';

class DateTimeInput extends InputField<DateTime> {
  const DateTimeInput(
    super.state, {
    super.key,

    // InputField specific
    super.errorBuilder,
    super.alignment = InputFieldAlignment.end,
    super.dense = false,
    super.padding = const EdgeInsets.all(16),
    super.fillColor,
    super.leading,
    super.trailing,
    super.enabled = true,
    super.label,

    // DateInput specific
    this.time = false,
    this.dateFormat = "dd/MM/yyyy",
    this.allowedDateRange,
  });

  final bool time;
  final String dateFormat;
  final DateTimeRange? allowedDateRange;

  @override
  Widget fieldBuilder(
    BuildContext context,
    WidgetRef ref, {
    required InputState<DateTime> state,
    required FocusNode focusNode,
  }) {
    final date = state.value;
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    openDialog() async {
      final date = await DateTimeDialog.show(
        initialDate: state.value,
        time: time,
        is24h: MediaQuery.of(context).alwaysUse24HourFormat,
        allowedDateRange: allowedDateRange,
      );
      if (date != null) {
        state.value = date;
      }
    }

    return Focus(
      focusNode: focusNode,
      onKeyEvent: (node, event) {
        if (event.logicalKey == LogicalKeyboardKey.space ||
            event.logicalKey == LogicalKeyboardKey.enter) {
          openDialog();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: BlankButton(
        onPressed: openDialog,
        child: AnimatedGlass(
          state: GlassState.opaque,
          color: colors.background,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          cornerRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat(
                  dateFormat,
                ).format(date),
                style: text.titleMedium,
              ),
              if (time)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "at",
                      style: text.labelLarge?.copyWith(
                        color: colors.onBackground.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${DateFormat(
                        "h:mm",
                        "nl",
                      ).format(date)}${MediaQuery.of(context).alwaysUse24HourFormat ? "" : date.hour >= 12 ? " PM" : " AM"}",
                      style: text.labelLarge,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
