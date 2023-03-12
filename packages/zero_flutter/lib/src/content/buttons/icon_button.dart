import 'package:zero_flutter/zero_flutter.dart';

class IconButton extends ButtonBase {
  final dynamic icon;

  IconButton({
    super.key,
    super.onPressed,
    super.link,
    super.loading = false,
    super.disabled = false,
    ButtonConfig config = IconButton.defaultConfig,
    this.icon,
  }) : super(
          config: config.copyWith(
            textIconSizes: config.transparency < 1
                ? config.textIconSizes
                : {
                    ButtonSize.small:
                        config.textIconSizes[ButtonSize.small]! * 1.1,
                    ButtonSize.medium:
                        config.textIconSizes[ButtonSize.medium]! * 1.1,
                    ButtonSize.large:
                        config.textIconSizes[ButtonSize.large]! * 1.1,
                  },
            paddings: config.transparency < 1
                ? config.paddings
                : {
                    ButtonSize.small: EdgeInsets.zero,
                    ButtonSize.medium: EdgeInsets.zero,
                    ButtonSize.large: EdgeInsets.zero,
                  },
          ),
        );

  static const ButtonConfig defaultConfig = ButtonConfig(
    paddings: {
      ButtonSize.small: EdgeInsets.all(6),
      ButtonSize.medium: EdgeInsets.all(10),
      ButtonSize.large: EdgeInsets.all(10),
    },
    cornerRadii: {
      ButtonSize.small: BorderRadius.all(Radius.circular(8)),
      ButtonSize.medium: BorderRadius.all(Radius.circular(12)),
      ButtonSize.large: BorderRadius.all(Radius.circular(16)),
    },
    textIconSizes: {
      ButtonSize.small: 20,
      ButtonSize.medium: 26,
      ButtonSize.large: 34,
    },
  );

  @override
  Widget buildButton(
    BuildContext context,
    ButtonState state,
    WidgetRef ref,
  ) {
    Widget loadedIcon = icon is IconData
        ? Icon(
            icon: icon,
            key: ValueKey(icon),
            color: config.contentColor(context),
            size: config.textIconSize,
          )
        : icon ?? Container();

    return state == ButtonState.loading
        ? Loader(
            color: config.contentColor(context),
            size: config.textIconSize,
          )
        : AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: loadedIcon,
          );
  }
}
