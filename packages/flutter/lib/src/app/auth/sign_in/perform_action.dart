import 'package:firebase_auth/firebase_auth.dart';
import 'package:zero_ui/zero_ui.dart';

Future<void> performAction(
  BuildContext context,
  WidgetRef ref,
  FormValues values,
) async {
  final mode = ref.watch(loginModeProvider);
  final authConfig = ref.read(authConfigProvider);
  try {
    switch (mode) {
      case LoginMode.password:
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: values.get<String>("email") ?? "",
          password: values.get<String>("password") ?? "",
        );

        break;
      case LoginMode.magicLink:
        ref.read(loginModeProvider.notifier).state = LoginMode.sendingMagicLink;
        try {
          final response = await authConfig.sendMagicLink
              ?.call(values.get<String>("email") ?? "");

          if (response?.sent == true) {
            ref.read(loginModeProvider.notifier).state =
                LoginMode.sentMagicLink;
            ref.read(inboxUrlProvider.notifier).state = response?.inboxUrl;
          } else {
            ref.read(loginModeProvider.notifier).state = LoginMode.magicLink;
          }
        } on FirebaseException catch (firebaseError) {
          showFirebaseError(context, ref, error: firebaseError);
        } catch (error) {
          showFirebaseError(context, ref);
        }
        break;
      case LoginMode.forgotPassword:
        ref.read(loginModeProvider.notifier).state =
            LoginMode.sendingPasswordReset;

        try {
          final response = await authConfig.sendPasswordReset
              ?.call(values.get<String>("email") ?? "");

          if (response?.sent == true) {
            ref.read(loginModeProvider.notifier).state =
                LoginMode.sentPasswordReset;
            ref.read(inboxUrlProvider.notifier).state = response?.inboxUrl;
          } else {
            ref.read(loginModeProvider.notifier).state =
                LoginMode.forgotPassword;
          }
        } on FirebaseException catch (firebaseError) {
          showFirebaseError(context, ref, error: firebaseError);
        } catch (error) {
          showFirebaseError(context, ref);
        }
        break;
      default:
        break;
    }
  } on FirebaseException catch (loginError) {
    showFirebaseError(context, ref, error: loginError);
  } catch (loginError) {
    showFirebaseError(context, ref);
  }
}
