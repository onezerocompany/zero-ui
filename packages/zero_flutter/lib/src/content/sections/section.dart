import 'package:zero_flutter/zero_flutter.dart';

class Section extends StatelessWidget {
  final double itemSpacing;
  final List<Widget> children;
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final String? footer;
  final Axis direction;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget? headerTrailing;

  const Section({
    super.key,
    required this.children,
    this.itemSpacing = 8,
    this.title,
    this.subtitle,
    this.icon,
    this.headerTrailing,
    this.footer,
    this.direction = Axis.vertical,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null ||
            subtitle != null ||
            icon != null ||
            headerTrailing != null)
          _SectionHeader(
            itemSpacing: itemSpacing,
            direction: direction,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            title: title,
            icon: icon,
            subtitle: subtitle,
            headerTrailing: headerTrailing,
          ),
        // add the item spacing to the top of each child except the first
        Flex(
          clipBehavior: Clip.none,
          direction: direction,
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children.map((child) {
            final index = children.indexOf(child);
            return Padding(
              padding: EdgeInsets.only(
                top: index == 0 || direction == Axis.horizontal
                    ? 0
                    : itemSpacing / 2,
                left: index == 0 || direction == Axis.vertical
                    ? 0
                    : itemSpacing / 2,
                bottom:
                    index == children.length - 1 || direction == Axis.horizontal
                        ? 0
                        : itemSpacing / 2,
                right:
                    index == children.length - 1 || direction == Axis.vertical
                        ? 0
                        : itemSpacing / 2,
              ),
              child: child,
            );
          }).toList(),
        ),
        if (footer != null)
          _SectionFooter(
            footer: footer,
            itemSpacing: itemSpacing,
          ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
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

class _SectionFooter extends StatelessWidget {
  const _SectionFooter({
    required this.footer,
    required this.itemSpacing,
  });

  final String? footer;
  final double itemSpacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: itemSpacing),
      child: Text(
        footer!,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
