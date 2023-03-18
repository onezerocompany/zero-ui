import 'package:zero_flutter/zero_flutter.dart';

class ListItem extends ButtonBase {
  final dynamic icon;
  final String label;
  final String? sublabel;
  final Widget? trailing;
  final bool trailingArrow;

  const ListItem({
    super.key,
    super.onPressed,
    super.link,
    super.loading = false,
    super.enabled = true,
    super.config = ListItem.defaultConfig,
    this.icon,
    required this.label,
    this.sublabel,
    this.trailing,
    this.trailingArrow = false,
  });

  static const ButtonConfig defaultConfig = ButtonConfig(
    transparency: 0.1,
    glassLike: true,
    paddings: {
      ButtonSize.small: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      ButtonSize.medium: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
      ButtonSize.large: EdgeInsets.symmetric(vertical: 18, horizontal: 22),
    },
    cornerRadii: {
      ButtonSize.small: BorderRadius.all(Radius.circular(12)),
      ButtonSize.medium: BorderRadius.all(Radius.circular(16)),
      ButtonSize.large: BorderRadius.all(Radius.circular(20)),
    },
    textIconSizes: {
      ButtonSize.small: 12,
      ButtonSize.medium: 16,
      ButtonSize.large: 26,
    },
  );

  @override
  Widget buildButton(BuildContext context, ButtonState state, WidgetRef ref) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget loadedIcon = icon is IconData
        ? Icon(
            icon: icon,
            color: config.contentColor(context),
            size: config.textIconSize * 1.4,
          )
        : icon ?? const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Section(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            itemSpacing: config.textIconSize * 0.4,
            children: [
              Section(
                direction: Axis.horizontal,
                itemSpacing: config.textIconSize * 0.4,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) loadedIcon,
                  Text(
                    label,
                    style: textTheme.displaySmall?.copyWith(
                      fontSize: config.textIconSize * 1.15,
                      color: config.contentColor(context),
                      height: 1,
                    ),
                  ),
                ],
              ),
              if (sublabel != null)
                Text(
                  sublabel!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall?.copyWith(
                    color: config.contentColor(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        if (trailing != null)
          Padding(
            padding: EdgeInsets.only(left: config.textIconSize * 0.7),
            child: trailing,
          ),
        if (trailingArrow)
          Padding(
            padding: EdgeInsets.only(left: config.textIconSize * 0.7),
            child: Icon(
              icon: Icons.arrow_forward_ios,
              color: config.contentColor(context),
              size: config.textIconSize,
            ),
          ),
      ],
    );
  }
}
