import 'package:zero_ui/zero_ui.dart';

export 'section_header.dart';
export 'section_footer.dart';

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
          SectionHeader(
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
          direction: direction,
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children.map(
            (child) {
              final index = children.indexOf(child);
              final isHidden = child is AnimatedHider && !child.visible;
              return Padding(
                padding: EdgeInsets.only(
                  top: index == 0 || direction == Axis.horizontal
                      ? 0
                      : !isHidden
                          ? (itemSpacing / 2)
                          : 0,
                  left: index == 0 || direction == Axis.vertical
                      ? 0
                      : !isHidden
                          ? (itemSpacing / 2)
                          : 0,
                  bottom: index == children.length - 1 ||
                          direction == Axis.horizontal
                      ? 0
                      : !isHidden
                          ? (itemSpacing / 2)
                          : 0,
                  right:
                      index == children.length - 1 || direction == Axis.vertical
                          ? 0
                          : !isHidden
                              ? (itemSpacing / 2)
                              : 0,
                ),
                child: child,
              );
            },
          ).toList(),
        ),
        if (footer != null)
          SectionFooter(
            footer: footer,
            itemSpacing: itemSpacing,
          ),
      ],
    );
  }
}
