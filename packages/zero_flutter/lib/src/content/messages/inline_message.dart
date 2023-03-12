import 'package:smooth_corner/smooth_corner.dart';
import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';

class InlineMessage extends StatelessWidget {
  const InlineMessage({
    super.key,
    required this.message,
    this.icon,
    this.color,
    this.cornerRadius = 12,
    this.action,
  });

  final double cornerRadius;
  final Color? color;
  final String message;
  final dynamic icon;
  final TextButton? action;

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? Theme.of(context).colorScheme.primary;
    final textColor = cardColor.foreground;

    Widget? resolvedIcon = icon is IconData
        ? Icon(
            icon: icon,
            color: textColor,
          )
        : icon;

    return SmoothContainer(
      smoothness: smoothness,
      borderRadius: BorderRadius.circular(cornerRadius),
      color: cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (resolvedIcon != null)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: resolvedIcon,
            ),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor,
                  ),
            ),
          ),
          if (action != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: action,
            ),
        ],
      ),
    );
  }
}
