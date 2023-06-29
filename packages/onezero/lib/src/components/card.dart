import 'package:onezero/onezero.dart';

class Card extends StatelessWidget {
  const Card({
    super.key,
    this.colors,
    this.edgeRadius = 8,
    this.edgeInset = 22,
    this.expanded = true,
    this.elevation = 0,
    this.title,
    this.subtitle,
    this.icon,
    this.child,
  });

  final ContainerColors? colors;

  final String? title;
  final String? subtitle;
  final IconData? icon;

  final double edgeRadius;
  final double edgeInset;
  final bool expanded;
  final double elevation;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = ZeroTheme.of(context);
    final cardColors = colors ?? theme.colors.card;

    Widget content = child ?? const SizedBox();
    Widget? header;
    if (title != null || subtitle != null) {
      header = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title?.isNotEmpty == true)
            Text(
              title!,
              color: cardColors.content,
              style: theme.typography.title.medium,
            ),
          if (subtitle?.isNotEmpty == true)
            Text(
              subtitle!,
              color: cardColors.content,
              priority: ColorPriority.secondary,
              style: theme.typography.title.small,
            ),
        ],
      );
    }

    if (icon != null) {
      header = Row(
        children: [
          Icon(
            icon: icon!,
            style: theme.typography.title.medium,
          ),
          SizedBox(width: edgeInset / 2),
          header ?? const SizedBox(),
        ],
      );
    }

    if (header != null) {
      content = Column(
        children: [
          header,
          SizedBox(height: edgeInset),
          content,
        ],
      );
    }

    return ContainerColorsProvider(
      colors: cardColors,
      child: Container(
        padding: EdgeInsets.all(edgeInset),
        decoration: BoxDecoration(
          color: colors?.surface.resolve(context) ??
              theme.colors.card.surface.resolve(context),
          borderRadius: BorderRadius.circular(edgeRadius),
          border: Border.all(
            color: colors?.edge.resolve(context) ??
                theme.colors.card.edge.resolve(context),
            width: 1,
          ),
          boxShadow: elevation > 0
              ? [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 0.2),
                    blurRadius: elevation,
                    spreadRadius: -elevation / 2,
                    offset: Offset(elevation / 2, elevation / 2),
                  ),
                ]
              : null,
        ),
        width: expanded ? double.infinity : null,
        child: content,
      ),
    );
  }
}
