import 'package:zero_flutter/zero_flutter.dart';

class Button extends ButtonBase {
  final String label;
  final dynamic leading;
  final dynamic trailing;

  const Button({
    super.key,
    super.onPressed,
    super.link,
    super.loading = false,
    super.disabled = false,
    super.config = Button.defaultConfig,
    required this.label,
    this.leading,
    this.trailing,
  });

  static const ButtonConfig defaultConfig = ButtonConfig(
    paddings: {
      ButtonSize.small: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      ButtonSize.medium: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
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
      ButtonSize.large: 20,
    },
  );

  @override
  Widget buildButton(BuildContext context, ButtonState state) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget loadedLeading = leading is IconData
        ? Icon(
            icon: leading,
            color: config.contentColor(context),
            size: config.textIconSize * 1.2,
          )
        : leading ?? Container();

    Widget loadedTrailing = trailing is IconData
        ? Icon(
            icon: trailing,
            color: config.contentColor(context),
            size: config.textIconSize * 1.2,
          )
        : trailing ?? Container();

    final labelText = Text(
      label,
      textAlign: TextAlign.center,
      style: textTheme.labelLarge?.copyWith(
            color: config.contentColor(context),
            fontSize: config.textIconSize,
            height: 1,
          ) ??
          TextStyle(
            color: config.contentColor(context),
            fontSize: config.textIconSize,
            height: 1,
          ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: config.fillWidth
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceBetween,
      children: [
        if (leading != null)
          SizedBox.square(
            dimension: config.textIconSize * 1.4,
            child: loadedLeading,
          ),
        if (leading != null)
          SizedBox(
            width: config.textIconSize / 2,
          ),
        if (config.fillWidth) Expanded(child: labelText) else labelText,
        if (trailing != null || state == ButtonState.loading)
          SizedBox(
            width: config.textIconSize / 2,
          ),
        if (state == ButtonState.loading)
          Loader(
            size: config.textIconSize,
            color: config.contentColor(context),
          ),
        if (state != ButtonState.loading && trailing != null)
          AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: state == ButtonState.hover
                ? const EdgeInsets.only(left: 10)
                : EdgeInsets.zero,
            child: loadedTrailing,
          ),
      ],
    );
  }
}
