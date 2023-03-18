import 'package:zero_flutter/zero_flutter.dart';

class TextButton extends ButtonBase {
  final String label;
  final dynamic leading;

  const TextButton({
    super.key,
    super.onPressed,
    super.link,
    super.loading = false,
    super.enabled = true,
    super.config = TextButton.defaultConfig,
    required this.label,
    this.leading,
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
  Widget buildButton(
    BuildContext context,
    ButtonState state,
    WidgetRef ref,
  ) {
    Widget loadedIcon = leading is IconData
        ? Icon(
            icon: leading,
            color: config.contentColor(context),
            size: config.textIconSize,
          )
        : leading ?? Container();

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null && state != ButtonState.loading) loadedIcon,
        if (state == ButtonState.loading)
          Loader(
            size: config.textIconSize,
            color: config.contentColor(context),
          ),
        if (leading != null || state == ButtonState.loading)
          SizedBox(width: super.config.textIconSize * 0.3),
        Text(
          label,
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
