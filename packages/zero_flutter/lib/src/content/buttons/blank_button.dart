import 'package:zero_flutter/zero_flutter.dart';

class BlankButton extends ButtonBase {
  final Widget child;

  const BlankButton({
    super.key,
    super.onPressed,
    super.link,
    super.loading = false,
    super.disabled = false,
    super.config = BlankButton.defaultConfig,
    required this.child,
  });

  static const ButtonConfig defaultConfig = ButtonConfig(
    fillColor: Colors.transparent,
    transparency: 1,
    paddings: {
      ButtonSize.small: EdgeInsets.zero,
      ButtonSize.medium: EdgeInsets.zero,
      ButtonSize.large: EdgeInsets.zero,
    },
    cornerRadii: {
      ButtonSize.small: BorderRadius.zero,
      ButtonSize.medium: BorderRadius.zero,
      ButtonSize.large: BorderRadius.zero,
    },
  );

  @override
  Widget buildButton(
    BuildContext context,
    ButtonState state,
    WidgetRef ref,
  ) {
    return child;
  }
}
