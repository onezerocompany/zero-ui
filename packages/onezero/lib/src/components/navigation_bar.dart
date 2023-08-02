import '../../onezero.dart';

class NavigationBar extends HookConsumerWidget {
  const NavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ZeroTheme.of(context);
    final colors = theme.colors.page;

    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: colors.surface.resolve(context),
          border: Border.all(
            color: colors.edge.resolve(context),
          ),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              height: 38,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: colors.surface.resolve(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const HotKeyBadge(
              hotKey: HotKey(
                modifiers: [HotKeyModifier.command],
                key: "K",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
