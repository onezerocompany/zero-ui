import '../../onezero.dart';

enum HotKeyModifier {
  command,
  control,
  option,
  shift,
}

class HotKey {
  const HotKey({
    required this.modifiers,
    required this.key,
  });

  final List<HotKeyModifier> modifiers;
  final String key;

  String get displayString {
    final modifiers = this.modifiers.map((modifier) {
      switch (modifier) {
        case HotKeyModifier.command:
          return "⌘";
        case HotKeyModifier.control:
          return "⌃";
        case HotKeyModifier.option:
          return "⌥";
        case HotKeyModifier.shift:
          return "⇧";
      }
    }).join(" + ");

    return "$modifiers + $key";
  }
}

class HotKeyBadge extends StatelessWidget {
  const HotKeyBadge({
    super.key,
    required this.hotKey,
  });

  final HotKey hotKey;

  @override
  Widget build(BuildContext context) {
    final theme = ZeroTheme.of(context);
    final colors = ContainerColors.of(context);
    return Opacity(
      opacity: 0.2,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: colors.content.resolve(context),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          hotKey.displayString,
          style: theme.typography.button.small.copyWith(weight: 500),
        ),
      ),
    );
  }
}
