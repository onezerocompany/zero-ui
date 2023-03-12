import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zero_flutter/zero_flutter.dart';

class PasswordChangeDialog extends HookConsumerWidget {
  const PasswordChangeDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      const PasswordChangeDialog(),
    );
  }

  static Future<bool> checkPassword() async {
    final methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(
      FirebaseAuth.instance.currentUser?.email ?? "",
    );
    return methods.contains(EmailAuthProvider.EMAIL_PASSWORD_SIGN_IN_METHOD);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPassword = useFuture(checkPassword()).data ?? false;
    final t = ref.watch(zeroLocalizationsProvider);
    return InputForm(
      onSaved: (values, saved) async {
        try {
          if (hasPassword) {
            final oldPassword = values["old_password"];
            if (oldPassword != null) {
              final credential = EmailAuthProvider.credential(
                email: FirebaseAuth.instance.currentUser?.email ?? "",
                password: oldPassword,
              );
              await FirebaseAuth.instance.currentUser
                  ?.reauthenticateWithCredential(credential);
            }
          }

          await FirebaseAuth.instance.currentUser?.updatePassword(
            values["new_password"],
          );
          if (context.mounted) {
            showSnackbar(
              context,
              title: t.profile.messages.passwordUpdated,
              icon: Icons.check,
            );
            Navigator.of(context).pop();
          }

          saved();
        } on FirebaseException catch (firebaseError) {
          showFirebaseError(context, ref, error: firebaseError);
        } catch (error) {
          showFirebaseError(context, ref);
        }
      },
      builder: (context, controller) {
        return Dialog(
          onConfirm: () {
            controller.save();
          },
          onDismiss: () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Center(
              child: Section(
                icon: Icons.password,
                title: "Change password",
                subtitle: "Set a new password for your account",
                children: [
                  if (hasPassword)
                    TextInput(
                      InputState<String>(
                        id: "old_password",
                        defaultValue: "",
                        validator: (String? value) {
                          if (value == null || value.isEmpty) return "required";
                          if (value.length < 6) return "too_short";
                          return null;
                        },
                      ),
                      leading: Icons.lock_person,
                      label: "Current password",
                      autofillHints: const [AutofillHints.password],
                      obscureText: true,
                      errorBuilder: (BuildContext context, String? error) {
                        if (error == "required") {
                          return "Password is required";
                        }
                        if (error == "too_short") {
                          return "Password is too short";
                        }
                        return null;
                      },
                    ),
                  TextInput(
                    InputState<String>(
                      id: "new_password",
                      defaultValue: "",
                      validator: (String? value) {
                        if (value == null || value.isEmpty) return "required";
                        if (value.length < 6) return "too_short";
                        return null;
                      },
                    ),
                    leading: Icons.lock_person,
                    label: "New password",
                    autofillHints: const [AutofillHints.password],
                    obscureText: true,
                    errorBuilder: (BuildContext context, String? error) {
                      if (error == "required") {
                        return "Password is required";
                      }
                      if (error == "too_short") {
                        return "Password is too short";
                      }
                      return null;
                    },
                  ),
                  TextInput(
                    InputState<String>(
                      id: "repeat_password",
                      defaultValue: "",
                      validator: (String? value) {
                        if (value == null || value.isEmpty) return "required";
                        if (controller.values["new_password"] != value) {
                          return "passwords_mismatch";
                        }
                        return null;
                      },
                    ),
                    leading: Icons.lock_reset,
                    label: "Repeat password",
                    autofillHints: const [AutofillHints.password],
                    obscureText: true,
                    errorBuilder: (BuildContext context, String? error) {
                      if (error == "required") {
                        return "Password is required";
                      }
                      if (error == "passwords_mismatch") {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                  ),
                  if (hasPassword)
                    Center(
                      child: TextButton(
                        icon: Icons.delete,
                        text: "Remove Password",
                        config: TextButton.defaultConfig.copyWith(
                          size: ButtonSize.medium,
                          contentColor: Colors.destructive,
                        ),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.currentUser?.unlink(
                              EmailAuthProvider.EMAIL_PASSWORD_SIGN_IN_METHOD,
                            );
                            if (context.mounted) {
                              showSnackbar(
                                context,
                                title: t.profile.messages.passwordRemoved,
                                icon: Icons.check,
                              );
                              Navigator.of(context).pop();
                            }
                          } on FirebaseException catch (firebaseError) {
                            showFirebaseError(
                              context,
                              ref,
                              error: firebaseError,
                            );
                          } catch (error) {
                            showFirebaseError(context, ref);
                          }
                        },
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PasswordChangeButton extends StatelessWidget {
  const PasswordChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        (isDark ? colors.background.withBrightness(1.5) : colors.surface);
    return Button(
      label: "Change password",
      leading: Icons.lock_person,
      config: Button.defaultConfig.copyWith(
        size: ButtonSize.medium,
        fillWidth: true,
        glassLike: true,
        fillColor: color,
      ),
      onPressed: () {
        PasswordChangeDialog.show(context);
      },
    );
  }
}
