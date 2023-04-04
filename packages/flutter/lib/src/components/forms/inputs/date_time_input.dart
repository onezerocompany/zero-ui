import 'package:flutter/services.dart';
import 'package:zero_ui/zero_ui.dart';
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
    this.day = false,
    this.dateFormat = "dd/MM/yyyy",
    this.allowedDateRange,
  });

  final bool time;
  final bool day;
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
    final locale = ref.watch(currentLocaleProvider);
    final is24h = MediaQuery.of(context).alwaysUse24HourFormat;

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
        enabled: enabled,
        onPressed: openDialog,
        child: Glass(
          state: GlassState.opaque,
          color: colors.background,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          cornerRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              if (day)
                Text(
                  DateFormat(
                    "EEEE",
                    locale.toString(),
                  ).format(date),
                  style: text.labelLarge?.copyWith(
                    color: colors.onBackground.withOpacity(0.5),
                  ),
                ),
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
                        is24h ? "H:mm" : "h:mm",
                        "nl",
                      ).format(date)}${is24h ? "" : date.hour >= 12 ? " PM" : " AM"}",
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
