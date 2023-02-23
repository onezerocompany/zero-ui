import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zero_flutter/zero_flutter.dart';

import 'google_signin.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Button(
        leading: SvgPicture.asset(
          "assets/icons/google.svg",
          package: "onezero_ui",
        ),
        label: ZeroUIAppLocalizations.of(context)!.googleSignInButtonLabel,
        config: Button.defaultConfig.copyWith(
          fillWidth: true,
          fillColor: Colors.white,
        ),
        onPressed: () async {
          try {
            OAuthCredential credential = await signInWithGoogle();
            FirebaseAuth.instance.signInWithCredential(credential);
          } on PlatformException catch (e) {
            if (e.code != 'ERROR_ABORTED_BY_USER') {
              showSnackbar(
                context,
                title: "Error signing in with Google",
                color: Colors.error,
              );
            }
          } catch (e) {
            showSnackbar(
              context,
              title: "Error signing in with Google",
              color: Colors.error,
            );
          }
        },
      ),
    );
  }
}
