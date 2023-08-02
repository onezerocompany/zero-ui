import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onezero/onezero.dart';

import 'package:flutter/services.dart';

class Button extends HookWidget {
  const Button({
    super.key,
    this.haptics = true,
    this.icon,
    this.trailingIcon,
    this.label,
    this.sublabel,
    this.color,
    this.disabled = false,
    this.onPressed,
  }) : assert(icon != null || trailingIcon != null || label != null);

  final bool haptics;
  final IconData? icon;
  final IconData? trailingIcon;
  final String? label;
  final String? sublabel;
  final DynamicColor? color;
  final bool disabled;

  // actions
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    Widget button;
    final theme = ZeroTheme.of(context);
    final typography = theme.typography;

    if (icon != null && trailingIcon != null && label?.isNotEmpty == true) {
      button = Row(
        children: [
          Icon(
            icon: icon!,
            style: typography.button.small,
            color: color,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label!),
              Text(sublabel!),
            ],
          ),
          const Spacer(),
          Icon(
            icon: trailingIcon!,
            style: typography.button.small,
            color: color,
          ),
        ],
      );
    } else if (icon != null && label?.isNotEmpty == true) {
      button = Row(
        children: [
          Icon(
            icon: icon!,
            style: typography.button.small,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(label!),
        ],
      );
    } else if (trailingIcon != null && label?.isNotEmpty == true) {
      button = Row(
        children: [
          Text(label!),
          const SizedBox(width: 8),
          Icon(
            icon: trailingIcon!,
            style: typography.button.small,
            color: color,
          ),
        ],
      );
    } else if (icon != null) {
      button = Icon(
        icon: icon!,
        style: typography.button.small,
        color: color,
      );
    } else if (trailingIcon != null) {
      button = Icon(
        icon: trailingIcon!,
        style: typography.button.small,
        color: color,
      );
    } else if (label?.isNotEmpty == true) {
      button = Text(label!);
    } else {
      throw Exception('Button must have an icon or label');
    }

    final active = useState(false);
    final hover = useState(false);
    final focus = useState(false);

    ColorState colorState = ColorState.normal;

    if (disabled) {
      colorState = ColorState.disabled;
    } else if (active.value) {
      colorState = ColorState.active;
    } else if (hover.value) {
      colorState = ColorState.hover;
    } else if (focus.value) {
      colorState = ColorState.focus;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        hover.value = true;
      },
      onExit: (_) {
        hover.value = false;
      },
      child: GestureDetector(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color?.resolve(
              context,
              state: colorState,
            ),
            border: Border.all(
              color: theme.colors.card.edge.resolve(context),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: button,
        ),
        onTapDown: (_) {
          if (haptics) HapticFeedback.lightImpact();
          active.value = true;
        },
        onTapCancel: () {
          active.value = false;
        },
        onTapUp: (_) {
          active.value = false;
        },
      ),
    );
  }
}
