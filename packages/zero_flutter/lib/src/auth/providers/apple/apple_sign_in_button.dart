import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zero_flutter/zero_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'apple_signin.dart';

class AppleSignInButton extends ConsumerWidget {
  const AppleSignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(zeroLocalizationsProvider);
    return SizedBox(
      width: double.infinity,
      child: Button(
        leading: SvgPicture.asset(
          "assets/icons/apple.svg",
          package: "zero_flutter",
          height: 22,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
        label: t.login.signInWith.apple,
        config: Button.defaultConfig.copyWith(
          fillWidth: true,
          fillColor: Colors.black,
        ),
        onPressed: () async {
          try {
            OAuthCredential credential = await signInWithApple();
            FirebaseAuth.instance.signInWithCredential(credential);
          } on SignInWithAppleAuthorizationException catch (e) {
            if (e.code != AuthorizationErrorCode.canceled) {
              showSnackbar(
                context,
                title: "Error signing in with Apple",
                color: Colors.error,
              );
            }
          } catch (e) {
            showSnackbar(
              context,
              title: "Error signing in with Apple",
              color: Colors.error,
            );
          }
        },
      ),
    );
  }
}
