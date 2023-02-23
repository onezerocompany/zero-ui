import 'package:zero_flutter/zero_flutter.dart';

class TextButton extends ButtonBase {
  final String text;
  final dynamic icon;

  const TextButton({
    super.key,
    super.onPressed,
    super.link,
    super.loading = false,
    super.disabled = false,
    super.config = TextButton.defaultConfig,
    required this.text,
    this.icon,
  });

  static const ButtonConfig defaultConfig = ButtonConfig(
    transparency: 1,
    hoverBackground: true,
    paddings: {
      ButtonSize.small: EdgeInsets.all(6),
      ButtonSize.medium: EdgeInsets.all(6),
      ButtonSize.large: EdgeInsets.all(6),
    },
    cornerRadii: {
      ButtonSize.small: BorderRadius.all(Radius.circular(6)),
      ButtonSize.medium: BorderRadius.all(Radius.circular(6)),
      ButtonSize.large: BorderRadius.all(Radius.circular(6)),
    },
  );

  @override
  Widget buildButton(BuildContext context, ButtonState state) {
    Widget loadedIcon = icon is IconData
        ? Icon(
            icon: icon,
            color: config.contentColor(context),
            size: config.textIconSize,
          )
        : icon ?? Container();

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null && state != ButtonState.loading) loadedIcon,
        if (state == ButtonState.loading)
          Loader(
            size: config.textIconSize,
            color: config.contentColor(context),
          ),
        if (icon != null || state == ButtonState.loading)
          SizedBox(width: super.config.textIconSize * 0.3),
        Text(
          text,
          style: TextStyle(
            color: config.contentColor(context),
            fontSize: config.textIconSize,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
      ],
    );
  }
}
