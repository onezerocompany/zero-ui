import 'package:zero_flutter/zero_flutter.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.itemSpacing,
    required this.direction,
    required this.crossAxisAlignment,
    required this.mainAxisSize,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.headerTrailing,
  });

  final double itemSpacing;
  final Axis direction;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final String? title;
  final IconData? icon;
  final String? subtitle;
  final Widget? headerTrailing;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: itemSpacing,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Icon(
                        icon: icon!,
                        size: 28,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  if (title != null)
                    Text(
                      title!,
                      style: text.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                ],
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
            ],
          ),
          const Spacer(),
          headerTrailing ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
