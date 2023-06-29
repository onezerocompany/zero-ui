import 'package:onezero/onezero.dart';

import 'package:flutter/services.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.haptics = true,
    this.leadingIcon,
    this.trailingIcon,
    this.label,
    this.sublabel,
  }) : assert(leadingIcon != null || trailingIcon != null || label != null);

  final bool haptics;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? label;
  final String? sublabel;

  @override
  Widget build(BuildContext context) {
    Widget button;

    if (leadingIcon != null &&
        trailingIcon != null &&
        label?.isNotEmpty == true) {
      button = Row(
        children: [
          Icon(icon: leadingIcon!),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label!),
              Text(sublabel!),
            ],
          ),
          const Spacer(),
          Icon(icon: trailingIcon!),
        ],
      );
    } else if (leadingIcon != null && label?.isNotEmpty == true) {
      button = Row(
        children: [
          Icon(icon: leadingIcon!),
          const SizedBox(width: 8),
          Text(label!),
        ],
      );
    } else if (trailingIcon != null && label?.isNotEmpty == true) {
      button = Row(
        children: [
          Text(label!),
          const SizedBox(width: 8),
          Icon(icon: trailingIcon!),
        ],
      );
    } else if (leadingIcon != null) {
      button = Icon(icon: leadingIcon!);
    } else if (trailingIcon != null) {
      button = Icon(icon: trailingIcon!);
    } else if (label?.isNotEmpty == true) {
      button = Text(label!);
    } else {
      throw Exception('Button must have an icon or label');
    }

    return GestureDetector(
      onTap: () {
        if (haptics) {
          HapticFeedback.lightImpact();
        }
        // Add your onTap logic here
      },
      child: button,
    );
  }
}
