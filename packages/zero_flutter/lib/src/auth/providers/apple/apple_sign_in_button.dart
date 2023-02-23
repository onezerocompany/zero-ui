import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zero_flutter/zero_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'apple_signin.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Button(
        leading: SvgPicture.asset(
          "assets/icons/apple.svg",
          package: "onezero_ui",
          height: 22,
          color: Colors.white,
        ),
        label: ZeroUIAppLocalizations.of(context)!.appleSignInButtonLabel,
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
