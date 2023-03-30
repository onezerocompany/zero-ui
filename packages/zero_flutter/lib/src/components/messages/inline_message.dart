import 'package:smooth_corner/smooth_corner.dart';
import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';

enum InlineMessageSize {
  small,
  medium,
  large,
}

const paddings = {
  InlineMessageSize.small: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  InlineMessageSize.medium: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  InlineMessageSize.large: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
};

const textSizes = <InlineMessageSize, double>{
  InlineMessageSize.small: 12,
  InlineMessageSize.medium: 14,
  InlineMessageSize.large: 16,
};

class InlineMessage extends StatelessWidget {
  const InlineMessage({
    super.key,
    this.size = InlineMessageSize.medium,
    required this.message,
    this.icon,
    this.color,
    this.cornerRadius = 12,
    this.action,
  });

  final InlineMessageSize size;
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
      padding: paddings[size],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (resolvedIcon != null)
            Padding(
              padding: EdgeInsets.only(right: paddings[size]?.right ?? 0),
              child: resolvedIcon,
            ),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor,
                    fontSize: textSizes[size],
                  ),
            ),
          ),
          if (action != null)
            Padding(
              padding: EdgeInsets.only(left: paddings[size]?.left ?? 0),
              child: action,
            ),
        ],
      ),
    );
  }
}
