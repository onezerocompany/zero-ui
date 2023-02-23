import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_flutter/globals.dart';
import 'package:zero_flutter/zero_flutter.dart';

class OmniButtonData {
  const OmniButtonData({
    required this.icon,
    this.onPressed,
    this.link,
  });
  final IconData icon;
  final VoidCallback? onPressed;
  final String? link;
}

class OmniButtons extends ConsumerWidget {
  const OmniButtons({
    super.key,
  });

  static const height = AdaptiveValue<double>(
    defaultValue: 52,
    values: [],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final isRoot = ref.watch(Router.isRoot);
    final open = ref.watch(omniBarOpen) || isRoot;
    final breakpoint = AdaptiveContext.breakpoint(context);
    final panels = AdaptiveContext.panels(context);
    final authConfig = AppConfig.of(context).authConfig;

    final omniButton = AspectRatio(
      aspectRatio: 1,
      child: IconButton(
        config: IconButton.defaultConfig.copyWith(
          size: ButtonSize.medium,
          fillColor: colors.primary,
        ),
        icon: open ? Icons.expand_more : Icons.menu,
        onPressed: () {
          if (open) {
            ref.read(omniBarOpen.notifier).state = false;
            omnibarFocus.unfocus();
          } else {
            ref.read(omniBarOpen.notifier).state = true;
          }
        },
      ),
    );

    return AnimatedContainer(
      duration: OmniBar.transitionDuration,
      curve: pageTransitionCurve,
      height: height.value(breakpoint),
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (FirebaseAuth.instance.currentUser == null)
              Button(
                leading: Icons.person,
                label: ZeroUIAppLocalizations.of(context)?.goToSignInPage ??
                    "Go to Sign In",
                config: Button.defaultConfig.copyWith(
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
                link: authConfig.signInLink,
              ),
            if (FirebaseAuth.instance.currentUser != null)
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
                    ref.read(omniBarOpen.notifier).state = true;
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
    super.disabled = false,
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
  Widget buildButton(BuildContext context, ButtonState state) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

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
                  return "${ZeroUIAppLocalizations.of(context)!.goodNight},";
                } else if (hour < 12) {
                  return "${ZeroUIAppLocalizations.of(context)!.goodMorning},";
                } else if (hour < 17) {
                  return "${ZeroUIAppLocalizations.of(context)!.goodAfternoon},";
                } else {
                  return "${ZeroUIAppLocalizations.of(context)!.goodEvening},";
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
              "Guest",
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
