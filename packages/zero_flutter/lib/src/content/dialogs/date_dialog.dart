import 'package:zero_flutter/zero_flutter.dart';

class DateDialog extends StatefulWidget {
  const DateDialog({
    super.key,
    this.initialDate,
    this.allowedDateRange,
  });

  final DateTime? initialDate;
  final DateTimeRange? allowedDateRange;

  static Future<DateTime?> show({
    DateTime? initialDate,
    DateTimeRange? allowedDateRange,
  }) async {
    return await showDialog(
      DateDialog(
        initialDate: initialDate,
        allowedDateRange: allowedDateRange,
      ),
    );
  }

  @override
  State<DateDialog> createState() => _DateDialogState();
}

class _DateDialogState extends State<DateDialog> {
  DateTime date = DateTime.now();

  @override
  initState() {
    super.initState();
    date = widget.initialDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final firstDate = widget.allowedDateRange?.start ?? DateTime(1900);
    final lastDate = widget.allowedDateRange?.end ?? DateTime(2100);
    return Dialog(
      onConfirm: () => Navigator.of(context).pop(date),
      onDismiss: () => Navigator.of(context).pop(),
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
              this.date = date,
            },
          ),
        ),
      ),
    );
  }
}
