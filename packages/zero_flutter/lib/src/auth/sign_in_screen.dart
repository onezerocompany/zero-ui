import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zero_flutter/zero_flutter.dart';

enum LoginMode {
  magicLink,
  password,
  forgotPassword,
}

final loginModeProvider =
    StateProvider<LoginMode>((ref) => LoginMode.magicLink);

class SignInScreen extends Page {
  const SignInScreen({
    super.key,
    super.layout = PageLayout.fullscreen,
    this.heroBuilder,
    required this.actionCodeSettings,
  });

  final ActionCodeSettings actionCodeSettings;

  final Widget? Function(
    BuildContext context,
    WidgetRef ref,
  )? heroBuilder;

  @override
  Color Function(BuildContext context)? get color =>
      (context) => Theme.of(context).colorScheme.surface;

  @override
  PageContentBuilder? get contentBuilder => (context, ref, isHorizontal) {
        final hero = heroBuilder?.call(context, ref);
        final isHorizontal = MediaQuery.of(context).size.width >
            MediaQuery.of(context).size.height;

        final mode = ref.watch(loginModeProvider);
        final router = AppConfig.router(context);
        final authConfig = AppConfig.of(context).authConfig;
        final size = MediaQuery.of(context).size;

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
                      if (authConfig.anonymousEnabled)
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Button(
                              leading: Icons.arrow_back,
                              label: ZeroUIAppLocalizations.of(context)
                                      ?.returnHomeButton ??
                                  "Return Home",
                              onPressed: () => GoRouter.of(context).go(
                                router.initialPage
                                        ?.metadata(context)
                                        .resolvedPath(
                                          context,
                                          fullPath: true,
                                        ) ??
                                    "/",
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
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: 360,
                      child: InputsForm(
                        onSaved: (values) =>
                            performAction(context, ref, values),
                        builder: (context, controller, dirty, valid) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedHider(
                                visible: authConfig.passwordEnabled,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: TextButton(
                                    icon: mode == LoginMode.forgotPassword
                                        ? Icons.arrow_back
                                        : mode == LoginMode.password
                                            ? Icons.magic_button
                                            : Icons.password,
                                    text: mode == LoginMode.forgotPassword
                                        ? ZeroUIAppLocalizations.of(context)!
                                            .returnToLoginButton
                                        : mode == LoginMode.password
                                            ? ZeroUIAppLocalizations.of(
                                                context,
                                              )!
                                                .magicLinkToggle
                                            : ZeroUIAppLocalizations.of(
                                                context,
                                              )!
                                                .passwordToggle,
                                    onPressed: () {
                                      if (mode == LoginMode.forgotPassword) {
                                        ref
                                            .read(loginModeProvider.notifier)
                                            .state = LoginMode.password;
                                      } else if (mode == LoginMode.password) {
                                        ref
                                            .read(loginModeProvider.notifier)
                                            .state = LoginMode.magicLink;
                                      } else {
                                        ref
                                            .read(loginModeProvider.notifier)
                                            .state = LoginMode.password;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              TextInput(
                                context,
                                id: 'email',
                                fillColor:
                                    Theme.of(context).colorScheme.background,
                                leading: Icons.alternate_email,
                                label: ZeroUIAppLocalizations.of(context)!
                                    .emailAddressLabel,
                                placeholder: ZeroUIAppLocalizations.of(context)!
                                    .emailAddressPlaceholder,
                                keyboardType: TextInputType.emailAddress,
                                autofillHints: const [AutofillHints.email],
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return ZeroUIAppLocalizations.of(context)!
                                        .emailAddressRequired;
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.go,
                                onSubmitted: (_) {
                                  if (mode == LoginMode.magicLink) {
                                    controller.save();
                                  } else {
                                    // next focus node
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                              ),
                              AnimatedCrossFade(
                                firstChild: const SizedBox(width: 360),
                                secondChild: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: TextInput(
                                    context,
                                    id: "password",
                                    fillColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    leading: Icons.password,
                                    label: ZeroUIAppLocalizations.of(context)!
                                        .passwordLabel,
                                    placeholder:
                                        ZeroUIAppLocalizations.of(context)!
                                            .passwordPlaceholder,
                                    obscureText: true,
                                    autofillHints: const [
                                      AutofillHints.password
                                    ],
                                  ),
                                ),
                                alignment: Alignment.topCenter,
                                firstCurve: Curves.easeInOut,
                                secondCurve: Curves.easeInOut,
                                sizeCurve: Curves.easeInOut,
                                crossFadeState: mode == LoginMode.password &&
                                        mode != LoginMode.forgotPassword
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 300),
                              ),
                              AnimatedCrossFade(
                                firstChild: SizedBox(
                                  width: 360,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: TextButton(
                                        config:
                                            TextButton.defaultConfig.copyWith(
                                          size: ButtonSize.small,
                                        ),
                                        text:
                                            ZeroUIAppLocalizations.of(context)!
                                                .forgotPasswordButton,
                                        onPressed: () {
                                          ref
                                              .read(loginModeProvider.notifier)
                                              .state = LoginMode.forgotPassword;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                secondChild: const SizedBox(width: 360),
                                alignment: Alignment.topCenter,
                                firstCurve: Curves.easeInOut,
                                secondCurve: Curves.easeInOut,
                                sizeCurve: Curves.easeInOut,
                                crossFadeState:
                                    mode != LoginMode.forgotPassword &&
                                            mode == LoginMode.password
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                duration: const Duration(milliseconds: 300),
                              ),
                              AnimatedCrossFade(
                                firstChild: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16.0,
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: Section(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Divider(
                                          indent: 20,
                                          endIndent: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground
                                              .withOpacity(0.1),
                                          thickness: 2,
                                        ),
                                      ),
                                      if (authConfig.googleEnabled)
                                        const GoogleSignInButton(),
                                      if (authConfig.appleEnabled)
                                        const AppleSignInButton(),
                                    ],
                                  ),
                                ),
                                secondChild: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 12.0,
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: Button(
                                    config: Button.defaultConfig.copyWith(
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                      fillWidth: true,
                                    ),
                                    disabled: !valid,
                                    leading: mode == LoginMode.password
                                        ? Icons.lock_open
                                        : Icons.magic_button,
                                    label: mode == LoginMode.forgotPassword
                                        ? ZeroUIAppLocalizations.of(context)!
                                            .forgotPasswordSendButton
                                        : mode == LoginMode.password
                                            ? ZeroUIAppLocalizations.of(
                                                context,
                                              )!
                                                .passwordSignInButton
                                            : ZeroUIAppLocalizations.of(
                                                context,
                                              )!
                                                .magicLinkSignInButton,
                                    onPressed: controller.save,
                                  ),
                                ),
                                alignment: Alignment.topCenter,
                                firstCurve: Curves.easeInOut,
                                secondCurve: Curves.easeInOut,
                                sizeCurve: Curves.easeInOut,
                                crossFadeState: !authConfig.passwordEnabled ||
                                        mode == LoginMode.password ||
                                        (!authConfig.appleEnabled &&
                                            !authConfig.googleEnabled)
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 300),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      };

  Future<void> performAction(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> values,
  ) async {
    final mode = ref.watch(loginModeProvider);
    try {
      switch (mode) {
        case LoginMode.password:
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: values["email"],
            password: values["password"],
          );
          break;
        case LoginMode.magicLink:
          // setup mail sending
          break;
        case LoginMode.forgotPassword:
          // setup mail sending
          break;
      }
    } on FirebaseAuthException catch (loginError) {
      switch (loginError.code) {
        case "user-not-found":
          showError(
            context,
            error: ZeroUIAppLocalizations.of(context)!.emailAddressNotFound,
          );
          break;
        case "wrong-password":
          showError(
            context,
            error: ZeroUIAppLocalizations.of(context)!.wrongPassword,
          );
          break;
        case "invalid-email":
          showError(
            context,
            error: ZeroUIAppLocalizations.of(context)!.invalidEmail,
          );
          break;
        case "user-disabled":
          showError(
            context,
            error: ZeroUIAppLocalizations.of(context)!.userDisabled,
          );
          break;
        default:
          showError(
            context,
            error: loginError.toString(),
          );
      }
    } catch (loginError) {
      showError(
        context,
        error: loginError.toString(),
      );
    }
  }
}
