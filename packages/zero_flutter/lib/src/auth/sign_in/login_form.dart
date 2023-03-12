import 'package:zero_flutter/zero_flutter.dart';

import 'perform_action.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({
    super.key,
    required this.mode,
    required this.loading,
  });

  final LoginMode mode;
  final bool loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    final enabledAuths = ref.watch(enabledAuthMethodsProvider);

    return InputForm(
      onSaved: (values, saved) => performAction(context, ref, values),
      builder: (context, controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedHider(
              visible: enabledAuths.password,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 12.0,
                ),
                child: Center(
                  child: TextButton(
                    icon: mode == LoginMode.forgotPassword
                        ? Icons.arrow_back
                        : mode == LoginMode.password
                            ? Icons.magic_button
                            : Icons.password,
                    text: mode == LoginMode.forgotPassword
                        ? t.login.buttons.back
                        : mode == LoginMode.password
                            ? t.login.signInWith.magicLink
                            : t.login.signInWith.password,
                    onPressed: () {
                      if (mode == LoginMode.forgotPassword) {
                        ref.read(loginModeProvider.notifier).state =
                            LoginMode.password;
                      } else if (mode == LoginMode.password) {
                        ref.read(loginModeProvider.notifier).state =
                            LoginMode.magicLink;
                      } else {
                        ref.read(loginModeProvider.notifier).state =
                            LoginMode.password;
                      }
                    },
                  ),
                ),
              ),
            ),
            TextInput(
              InputState<String>(
                id: "email",
                defaultValue: "",
                validator: (value) {
                  if (value?.isEmpty == true) return t.login.fields.email.required;
                  return null;
                },
              ),
              fillColor: Theme.of(context).colorScheme.background,
              leading: Icons.alternate_email,
              label: t.login.fields.email.label,
              placeholder: t.login.fields.email.enter,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
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
                  InputState<String>(
                    id: "password",
                    defaultValue: "",
                  ),
                  fillColor: Theme.of(context).colorScheme.background,
                  leading: Icons.password,
                  label: t.login.fields.password.label,
                  placeholder: t.login.fields.password.enter,
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                ),
              ),
              alignment: Alignment.topCenter,
              firstCurve: Curves.easeInOut,
              secondCurve: Curves.easeInOut,
              sizeCurve: Curves.easeInOut,
              crossFadeState:
                  mode == LoginMode.password && mode != LoginMode.forgotPassword
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
            AnimatedCrossFade(
              firstChild: SizedBox(
                width: 360,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: TextButton(
                      config: TextButton.defaultConfig.copyWith(
                        size: ButtonSize.small,
                      ),
                      text: t.login.forgotPassword.buttons.forgot,
                      onPressed: () {
                        ref.read(loginModeProvider.notifier).state =
                            LoginMode.forgotPassword;
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
                  mode != LoginMode.forgotPassword && mode == LoginMode.password
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
                      padding: const EdgeInsets.only(
                        bottom: 8.0,
                      ),
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
                    if (enabledAuths.google) const GoogleSignInButton(),
                    if (enabledAuths.apple) const AppleSignInButton(),
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
                    fillColor: Theme.of(context).colorScheme.onBackground,
                    fillWidth: true,
                  ),
                  disabled: !controller.valid,
                  loading: loading,
                  leading: mode == LoginMode.password
                      ? Icons.lock_open
                      : Icons.magic_button,
                  label: mode == LoginMode.forgotPassword
                      ? t.login.forgotPassword.buttons.sendLink
                      : mode == LoginMode.password
                          ? t.login.buttons.signin
                          : t.login.magicLink.buttons.send,
                  onPressed: controller.save,
                ),
              ),
              alignment: Alignment.topCenter,
              firstCurve: Curves.easeInOut,
              secondCurve: Curves.easeInOut,
              sizeCurve: Curves.easeInOut,
              crossFadeState: !enabledAuths.password ||
                      mode == LoginMode.password ||
                      (!enabledAuths.apple && !enabledAuths.google)
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        );
      },
    );
  }
}
