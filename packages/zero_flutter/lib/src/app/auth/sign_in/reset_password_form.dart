import 'package:firebase_auth/firebase_auth.dart';
import 'package:zero_flutter/zero_flutter.dart';

class ResetPasswordForm extends ConsumerWidget {
  const ResetPasswordForm({
    super.key,
    required this.oobCode,
  });

  final String? oobCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    return InputForm(
      onSaved: (values, saved) async {
        final password = values.get<String>('password') ?? '';
        final confirmPassword = values.get<String>('confirm_password') ?? '';
        if (password != confirmPassword) {
          showError(
            context,
            error: t.login.forgotPassword.dialog.popups.passwordMismatch,
          );
          return;
        }
        try {
          await FirebaseAuth.instance.confirmPasswordReset(
            code: oobCode!,
            newPassword: password,
          );
          ref
              .read(
                loginModeProvider.notifier,
              )
              .state = LoginMode.password;
          if (context.mounted) {
            showSnackbar(
              context,
              title:
                  "Password updated successfully! Please login using your new password.",
              icon: Icons.check,
              duration: const Duration(seconds: 10),
            );
          }
        } on FirebaseAuthException catch (firebaseError) {
          if (firebaseError.code == 'invalid-action-code') {
            showError(
              context,
              error: t.login.forgotPassword.dialog.popups.codeExpired,
            );
            return;
          }
          showFirebaseError(
            context,
            ref,
            error: firebaseError,
          );
        } catch (_) {
          showFirebaseError(context, ref);
        }
      },
      builder: (context, controller) {
        return Section(
          children: [
            TextButton(
              label: t.login.buttons.back,
              leading: Icons.arrow_back,
              onPressed: () {
                ref
                    .read(
                      loginModeProvider.notifier,
                    )
                    .state = LoginMode.password;
              },
            ),
            Text(
              t.login.forgotPassword.dialog.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              t.login.forgotPassword.dialog.message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            TextInput(
              InputState<String>(
                id: 'password',
                defaultValue: '',
                validator: (value) {
                  if ((value?.length ?? 0) < 6) return "too_short";
                  return null;
                },
              ),
              // label: ZeroUIAppLocalizations.of(context)!.newPassword,
              label: t.login.forgotPassword.dialog.fields.newPassword.label,
              placeholder:
                  t.login.forgotPassword.dialog.fields.newPassword.enter,
              leading: Icons.lock,
              obscureText: true,
              fillColor: Theme.of(context).colorScheme.background,

              errorBuilder: (context, code) {
                switch (code) {
                  case "too_short":
                    return t
                        .login.forgotPassword.dialog.fields.newPassword.short;
                  default:
                    return null;
                }
              },
            ),
            TextInput(
              InputState<String>(
                id: 'confirm_password',
                defaultValue: '',
                validator: (value) {
                  if (value != controller.values.get<String>('password')) {
                    return "mismatch";
                  }
                  return null;
                },
              ),
              label: t.login.forgotPassword.dialog.fields.confirmPassword.label,
              placeholder:
                  t.login.forgotPassword.dialog.fields.confirmPassword.enter,
              leading: Icons.lock_reset,
              obscureText: true,
              fillColor: Theme.of(context).colorScheme.background,
              errorBuilder: (context, code) {
                switch (code) {
                  case "mismatch":
                    // return ZeroUIAppLocalizations.of(context)!
                    //     .passwordsDoNotMatch;
                    return t.login.forgotPassword.dialog.fields.confirmPassword
                        .mismatch;
                  default:
                    return null;
                }
              },
            ),
            const SizedBox(height: 8),
            Button(
              config: Button.defaultConfig.copyWith(
                fillWidth: true,
                fillColor: Theme.of(context).colorScheme.primary,
              ),
              leading: Icons.arrow_forward,
              onPressed: controller.save,
              enabled: controller.valid,
              label: t.login.forgotPassword.dialog.buttons.update,
            ),
          ],
        );
      },
    );
  }
}
