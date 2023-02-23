import 'package:zero_flutter/zero_flutter.dart';

enum ActionButtonPosition {
  start,
  middle,
  end,
}

class ActionButton extends ButtonBase {
  // style
  final ActionButtonPosition position;
  final dynamic icon;

  // state
  final bool active;

  const ActionButton({
    super.key,
    super.onPressed,
    super.link,
    super.loading = false,
    super.disabled = false,
    super.config = ActionButton.defaultConfig,
    this.position = ActionButtonPosition.middle,
    this.icon,
    this.active = false,
  });

  static const ButtonConfig defaultConfig = ButtonConfig(
    paddings: {
      ButtonSize.small: EdgeInsets.all(12),
      ButtonSize.medium: EdgeInsets.all(18),
      ButtonSize.large: EdgeInsets.all(22),
    },
    cornerRadii: {
      ButtonSize.small: BorderRadius.all(Radius.circular(12)),
      ButtonSize.medium: BorderRadius.all(Radius.circular(22)),
      ButtonSize.large: BorderRadius.all(Radius.circular(28)),
    },
    textIconSizes: {
      ButtonSize.small: 24,
      ButtonSize.medium: 38,
      ButtonSize.large: 48,
    },
  );

  @override
  Widget buildButton(
    BuildContext context,
    ButtonState state,
  ) {
    Widget loadedIcon = icon is IconData
        ? Icon(
            icon: icon,
            color: config.contentColor(context),
            size: config.textIconSize,
          )
        : icon ?? Container();

    return state == ButtonState.loading
        ? Loader(
            size: config.textIconSize,
            color: config.contentColor(context),
          )
        : FittedBox(
            child: loadedIcon,
          );
  }
}
