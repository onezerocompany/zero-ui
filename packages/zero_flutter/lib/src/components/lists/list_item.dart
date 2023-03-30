import 'package:zero_flutter/zero_flutter.dart';

class ListItem extends ButtonBase {
  final dynamic leading;
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
    this.leading,
    required this.label,
    this.sublabel,
    this.trailing,
    this.trailingArrow = false,
  });

  static const ButtonConfig defaultConfig = ButtonConfig(
    transparency: 0.1,
    glassLike: true,
    fillWidth: true,
    paddings: {
      ButtonSize.small: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      ButtonSize.medium: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
      ButtonSize.large: EdgeInsets.symmetric(vertical: 28, horizontal: 30),
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

    Widget loadedIcon = leading is IconData
        ? Icon(
            icon: leading,
            color: config.contentColor(context),
            size: config.textIconSize * 1.4,
          )
        : leading ?? const SizedBox.shrink();

    final labels = Section(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      itemSpacing: config.textIconSize,
      children: [
        if (leading != null) loadedIcon,
        Section(
          itemSpacing: config.textIconSize * 0.3,
          children: [
            Text(
              label,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: textTheme.displaySmall?.copyWith(
                fontSize: config.textIconSize,
                color: config.contentColor(context),
                height: 1,
              ),
            ),
            if (sublabel != null)
              Text(
                sublabel!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleSmall?.copyWith(
                  fontSize: config.textIconSize * 0.9,
                  color: config.contentColor(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ],
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        config.fillWidth ? Expanded(child: labels) : labels,
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
