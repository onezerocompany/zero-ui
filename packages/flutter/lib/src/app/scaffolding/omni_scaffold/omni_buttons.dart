import 'package:zero_ui/globals.dart';
import 'package:zero_ui/zero_ui.dart';

final nameProvider = StateProvider<String?>((ref) => null);
final pictureProvider = StateProvider<Widget?>((ref) => null);

class OmniButtons extends ConsumerWidget {
  const OmniButtons({
    super.key,
  });

  static const double height = 52;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    final level = ref.watch(currentRouterLevelProvider);

    final colors = Theme.of(context).colorScheme;
    final isRoot = level == 0;
    final open = ref.watch(omniBarStateProvider).open || isRoot;
    final panels = ref.watch(panelsProvider);
    final authConfig = ref.watch(authConfigProvider);
    ref.watch(userIdProvider);

    final omniButton = AspectRatio(
      aspectRatio: 1,
      child: IconButton(
        config: IconButton.defaultConfig.copyWith(
          size: ButtonSize.medium,
          fillColor: colors.primary,
        ),
        icon: open ? Icons.expand_more : Icons.menu,
        onPressed: () {
          ref.read(omniBarStateProvider.notifier).toggleOpen();
        },
      ),
    );

    return AnimatedContainer(
      duration: OmniBar.transitionDuration,
      curve: pageTransitionCurve,
      height: height,
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileClickable(
              link: authConfig.profileLink,
            ),
            const Spacer(),
            AnimatedOpacity(
              duration: OmniBar.transitionDuration,
              opacity: panels < 2 && !open ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 22.0),
                child: IconButton(
                  config: IconButton.defaultConfig.copyWith(
                    size: ButtonSize.small,
                    transparency: 1,
                  ),
                  icon: Icons.search,
                  onPressed: () {
                    ref.read(omniBarStateProvider.notifier).setOpen(true);
                    Future.delayed(
                      OmniBar.transitionDuration,
                      () => omniSearchFocus.requestFocus(),
                    );
                  },
                ),
              ),
            ),
            AnimatedOpacity(
              duration: OmniBar.transitionDuration,
              opacity: isRoot ? 0 : 1,
              child: omniButton,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileClickable extends ButtonBase {
  const ProfileClickable({
    super.key,
    super.enabled = true,
    super.config = defaultConfig,
    super.loading = false,
    super.link,
    super.onPressed,
  });

  static const defaultConfig = ButtonConfig(
    size: ButtonSize.medium,
    transparency: 1,
  );

  @override
  Widget buildButton(BuildContext context, ButtonState state, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final name = ref.watch(nameProvider);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipOval(
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                child: const Center(
                  child: Icon(
                    icon: Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // time of day greeting
              () {
                final hour = DateTime.now().hour;
                if (hour < 4) {
                  return "${t.scaffold.greetings.night},";
                } else if (hour < 12) {
                  return "${t.scaffold.greetings.morning},";
                } else if (hour < 17) {
                  return "${t.scaffold.greetings.afternoon},";
                } else {
                  return "${t.scaffold.greetings.evening},";
                }
              }(),
              style: text.labelLarge?.copyWith(
                height: 1,
                fontWeight: FontWeight.w600,
                color: colors.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              name ?? t.scaffold.guest,
              style: text.titleMedium?.copyWith(
                height: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
