import 'package:go_router/go_router.dart';
import 'package:zero_flutter/zero_flutter.dart';

import 'login_form.dart';
import 'magic_link_notice.dart';
import 'password_reset_notice.dart';
import 'reset_password_form.dart';

enum LoginMode {
  magicLink,
  password,
  sendingPasswordReset,
  sentPasswordReset,
  forgotPassword,
  sendingMagicLink,
  sentMagicLink,
  resettingPassword,
}

final loginModeProvider = StateProvider<LoginMode>(
  (ref) {
    final query = Uri.base.queryParameters;

    if (query["passwordReset"] == "true" &&
        query.containsKey("code") &&
        query.containsKey("email")) {
      return LoginMode.resettingPassword;
    }
    return LoginMode.magicLink;
  },
);
final inboxUrlProvider = StateProvider<String?>((ref) => null);

class SignInScreen extends Page {
  const SignInScreen(
    super.state, {
    required super.metadata,
    super.key,
    super.layout = PageLayout.fullscreen,
    this.heroBuilder,
  });

  final Widget? Function(
    BuildContext context,
    WidgetRef ref,
  )? heroBuilder;

  @override
  Color Function(BuildContext context)? get color =>
      (context) => Theme.of(context).colorScheme.surface;

  @override
  PageContentBuilder? get contentBuilder => (context, ref, isHorizontal) {
        final t = ref.watch(zeroLocalizationsProvider);
        final router = ref.watch(routerProvider);

        final enabledAuths = ref.watch(enabledAuthMethodsProvider);

        final mode = ref.watch(loginModeProvider);
        final loading = mode == LoginMode.sendingMagicLink ||
            mode == LoginMode.sendingPasswordReset;

        final inboxUrl = ref.watch(inboxUrlProvider);
        final passwordResetCode = Uri.base.queryParameters["code"];

        final size = MediaQuery.of(context).size;
        final isHorizontal = MediaQuery.of(context).size.width >
            MediaQuery.of(context).size.height;

        final hero = heroBuilder?.call(context, ref);

        Widget currentContent() {
          switch (mode) {
            case LoginMode.sentMagicLink:
              return MagicLinkNotice(inboxUrl: inboxUrl);
            case LoginMode.sentPasswordReset:
              return PasswordResetNotice(inboxUrl: inboxUrl);
            case LoginMode.resettingPassword:
              return ResetPasswordForm(oobCode: passwordResetCode);
            default:
              return LoginForm(
                mode: mode,
                loading: loading,
              );
          }
        }

        return PageContent(
          scrollable: false,
          extend: true,
          statusBarStyle: StatusBarStyle.light,
          child: CustomScrollView(
            scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
            slivers: [
              // fill half the screen with the hero
              SliverFillViewport(
                padEnds: false,
                viewportFraction: isHorizontal ? 1 - (500 / size.width) : 0.5,
                delegate: SliverChildListDelegate.fixed([
                  Stack(
                    children: [
                      if (hero != null) hero,
                      if (enabledAuths.anonymous)
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Button(
                              leading: Icons.arrow_back,
                              label: t.login.buttons.back,
                              onPressed: () => GoRouter.of(context).go(
                                router.initialPath,
                              ),
                              config: Button.defaultConfig.copyWith(
                                size: ButtonSize.small,
                                fillColor:
                                    Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: SizedBox(
                      width: 360,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        switchInCurve: Curves.easeInOut,
                        switchOutCurve: Curves.easeInOut,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: currentContent(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      };
}
