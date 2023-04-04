import 'package:zero_ui/zero_ui.dart';

class DateRangeInput extends HookConsumerWidget {
  const DateRangeInput({
    super.key,
    required this.startState,
    required this.endState,
    this.dateFormat = "d MMM yyyy",
    this.day = true,
    this.time = false,
    this.dense = false,
    this.fillColor,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.label,
  });

  final InputState<DateTime> startState;
  final InputState<DateTime> endState;
  final String? dateFormat;
  final bool day;
  final bool time;
  final bool dense;
  final Color? fillColor;
  final dynamic leading;
  final dynamic trailing;
  final bool enabled;
  final String? label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final color = fillColor ?? colors.surface;
    final foregroundColor = color.foreground;

    useValueChanged(
      startState.value,
      (_, __) => {
        if (startState.value.isAfter(endState.value))
          {
            endState.silentValueUpdate(startState.value),
          }
      },
    );

    Widget fields = Row(
      children: [
        Expanded(
          child: DateTimeInput(
            startState,
            day: day,
            time: time,
            dense: true,
            dateFormat: "d MMM yyyy",
            fillColor: Theme.of(context).colorScheme.background,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            icon: Icons.arrow_forward,
            size: 24,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        Expanded(
          child: DateTimeInput(
            endState,
            day: day,
            time: time,
            dense: true,
            dateFormat: "d MMM yyyy",
            fillColor: Theme.of(context).colorScheme.background,
            allowedDateRange: DateTimeRange(
              start: startState.value,
              end: startState.value.add(const Duration(days: 365)),
            ),
          ),
        ),
      ],
    );

    if (!dense) {
      fields = Glass(
        state: GlassState.translucent,
        color: color,
        transparency: 0.9,
        cornerRadius: BorderRadius.circular(12),
        padding: const EdgeInsets.all(18),
        child: Section(
          itemSpacing: 10,
          children: [
            Section(
              direction: Axis.horizontal,
              itemSpacing: 10,
              children: [
                if (leading != null)
                  leading is IconData
                      ? Icon(
                          icon: leading,
                          color: foregroundColor,
                        )
                      : leading,
                if (label != null)
                  Text(
                    label!,
                    style: text.bodyLarge?.copyWith(
                      color: foregroundColor,
                    ),
                  ),
                if (trailing != null)
                  trailing is IconData
                      ? Icon(
                          icon: trailing,
                          color: foregroundColor,
                        )
                      : trailing,
              ],
            ),
            fields,
          ],
        ),
      );
    }

    return fields;
  }
}
