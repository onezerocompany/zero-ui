import 'package:flutter/services.dart';
import 'package:zero_flutter/zero_flutter.dart';

enum HourMinutesFieldType {
  hour,
  minutes,
}

class DateTimeDialog extends StatefulWidget {
  const DateTimeDialog({
    super.key,
    this.initialDate,
    this.allowedDateRange,
    this.is24h = true,
    this.time = false,
  });

  final bool time;
  final bool is24h;
  final DateTime? initialDate;
  final DateTimeRange? allowedDateRange;

  static Future<DateTime?> show({
    DateTime? initialDate,
    bool time = false,
    bool is24h = true,
    DateTimeRange? allowedDateRange,
  }) async {
    return await showDialog(
      DateTimeDialog(
        initialDate: initialDate,
        is24h: is24h,
        allowedDateRange: allowedDateRange,
        time: time,
      ),
    );
  }

  @override
  State<DateTimeDialog> createState() => _DateTimeDialogState();
}

class _DateTimeDialogState extends State<DateTimeDialog> {
  DateTime date = DateTime.now();
  final hoursController = TextEditingController();
  final minutesController = TextEditingController();

  @override
  initState() {
    date = widget.initialDate ?? DateTime.now();
    if (widget.is24h) {
      hoursController.text = date.hour.toString().padLeft(2, "0");
    } else {
      hoursController.text = date.hour == 0
          ? "12"
          : date.hour > 12
              ? (date.hour - 12).toString().padLeft(2, "0")
              : date.hour.toString().padLeft(2, "0");
    }
    minutesController.text = date.minute.toString().padLeft(2, "0");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final firstDate = widget.allowedDateRange?.start ?? DateTime(1900);
    final lastDate = widget.allowedDateRange?.end ?? DateTime(2100);

    return Dialog(
      onConfirm: () => Navigator.of(context).pop(date),
      onDismiss: () => Navigator.of(context).pop(),
      // Two big text fields for hours and minutes
      // seperated by a colon
      // on the right side two buttons for AM and PM (or 24h)
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              child: CalendarDatePicker(
                initialDate: date,
                firstDate: firstDate,
                lastDate: lastDate,
                onDateChanged: (date) => setState(
                  () => {
                    this.date = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      this.date.hour,
                      this.date.minute,
                      0,
                    ),
                  },
                ),
              ),
            ),
          ),
          if (widget.time)
            Container(
              padding: const EdgeInsets.all(22),
              color: colors.onSurface.withOpacity(0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HourMinutesField(
                    type: HourMinutesFieldType.hour,
                    is24h: widget.is24h,
                    controller: hoursController,
                    onSubmitted: (_) => {
                      Navigator.of(context).pop(date),
                    },
                    onChanged: (value) {
                      final int parsed = int.tryParse(value) ?? 0;
                      setState(() {
                        if (widget.is24h) {
                          date = date.add(Duration(hours: parsed - date.hour));
                        } else {
                          if (parsed == 12 && date.hour < 12) {
                            date = date.subtract(Duration(hours: date.hour));
                          } else if (date.hour < 12) {
                            date =
                                date.add(Duration(hours: parsed - date.hour));
                          } else {
                            date = date.add(
                              Duration(hours: parsed - date.hour + 12),
                            );
                          }
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 12),
                  Text(
                    ":",
                    style: text.displayMedium?.copyWith(height: 1),
                  ),
                  const SizedBox(width: 12),
                  HourMinutesField(
                    type: HourMinutesFieldType.minutes,
                    is24h: widget.is24h,
                    controller: minutesController,
                    onSubmitted: (_) => {
                      Navigator.of(context).pop(date),
                    },
                    onChanged: (value) {
                      final int parsed = int.tryParse(value) ?? 0;
                      setState(() {
                        date =
                            date.add(Duration(minutes: parsed - date.minute));
                      });
                    },
                  ),
                  if (!widget.is24h)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            config: TextButton.defaultConfig.copyWith(
                              transparency: date.hour < 12 ? 0 : 0.8,
                              fillColor: colors.primary,
                              contentColor: isDark
                                  ? colors.onBackground
                                  : date.hour < 12
                                      ? colors.onPrimary
                                      : colors.primary,
                            ),
                            label: "AM",
                            onPressed: () {
                              setState(() {
                                if (date.hour > 12) {
                                  date = date.subtract(
                                    const Duration(hours: 12),
                                  );
                                } else if (date.hour == 12) {
                                  date = date.subtract(
                                    const Duration(hours: 12),
                                  );
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 6),
                          TextButton(
                            config: TextButton.defaultConfig.copyWith(
                              transparency: date.hour < 12 ? 0.8 : 0,
                              fillColor: colors.primary,
                              contentColor: isDark
                                  ? colors.onBackground
                                  : date.hour < 12
                                      ? colors.primary
                                      : colors.onPrimary,
                            ),
                            label: "PM",
                            onPressed: () {
                              setState(() {
                                if (date.hour < 12) {
                                  date = date.add(
                                    const Duration(hours: 12),
                                  );
                                } else if (date.hour == 12) {
                                  date = date.add(
                                    const Duration(hours: 12),
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class HourMinutesField extends StatelessWidget {
  const HourMinutesField({
    super.key,
    required this.is24h,
    required this.controller,
    required this.type,
    required this.onChanged,
    required this.onSubmitted,
  });

  final bool is24h;
  final HourMinutesFieldType type;
  final TextEditingController controller;
  final Function(String value) onChanged;
  final Function(String value) onSubmitted;

  @override
  build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Glass(
      state: GlassState.opaque,
      cornerRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          width: 80,
          child: TextField(
            expands: false,
            maxLines: 1,
            controller: controller,
            textAlign: TextAlign.center,
            style: text.displayLarge,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration.collapsed(hintText: null),
            // block any non digit input
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onSubmitted: onSubmitted,
            onChanged: (value) {
              // cut off anything over 2 digits (e.g. 123 -> 23, 1234 -> 34)
              final int parsed = int.tryParse(
                    value.length > 2
                        ? value.substring(value.length - 2, value.length)
                        : value,
                  ) ??
                  0;
              String updatedText = parsed.toString();
              // all fields should be 0 or higher
              if (parsed < 0) updatedText = "0";
              // if the field is the hour field
              // limit the value to 23 or 12 depending on the format
              if (type == HourMinutesFieldType.hour) {
                if (MediaQuery.of(context).alwaysUse24HourFormat) {
                  if (parsed > 23) updatedText = "23";
                } else {
                  if (parsed > 12) {
                    updatedText = "12";
                  }
                }
              }
              // if the field is the minutes field
              // limit the value to 59
              if (type == HourMinutesFieldType.minutes) {
                if (parsed > 59) updatedText = "59";
              }
              updatedText = updatedText.padLeft(2, "0");
              if (value != updatedText) {
                // update the text field
                controller.text = updatedText;
                // move the cursor to the end of the text
                controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: updatedText.length),
                );
              }
              onChanged(updatedText);
            },
          ),
        ),
      ),
    );
  }
}
