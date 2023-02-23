import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zero_flutter/zero_flutter.dart';

var actionCodeSetting = ActionCodeSettings(
  url: 'https://onezero-ui.web.app',
  handleCodeInApp: true,
  iOSBundleId: 'company.onezero.ui',
  androidPackageName: 'company.onezero.ui',
  androidInstallApp: true,
  androidMinimumVersion: '1',
);

class LoginPage extends SignInScreen {
  LoginPage({
    super.key,
  }) : super(
          actionCodeSettings: actionCodeSetting,
        );

  @override
  PageMetadata metadata(BuildContext context) {
    return PageMetadata(
      icon: Icons.person,
      name: (context) => "Login",
      description: (context) => "Login to your account",
      path: "/login",
      hideOmniBar: true,
    );
  }

  @override
  Widget? Function(BuildContext context, WidgetRef ref)? get heroBuilder =>
      (context, ref) {
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Text(
              "Catalog App",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary.foreground,
                  ),
            ),
          ),
        );
      };
}
