import 'package:firebase_auth/firebase_auth.dart';
import 'package:zero_ui/zero_ui.dart';

var actionCodeSetting = ActionCodeSettings(
  url: 'https://onezero-ui.web.app',
  handleCodeInApp: true,
  iOSBundleId: 'company.onezero.ui',
  androidPackageName: 'company.onezero.ui',
  androidInstallApp: true,
  androidMinimumVersion: '1',
);

PageMetadata loginPageMetadata(Locale locale) {
  return const PageMetadata(
    icon: Icons.person,
    name: "Login",
    description: "Login to your account",
    path: "/login",
    hideOmniBar: true,
  );
}

class LoginPage extends SignInScreen {
  const LoginPage(
    super.state, {
    super.metadata = loginPageMetadata,
    super.key,
  });

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
