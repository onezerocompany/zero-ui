import 'package:zero_flutter/zero_flutter.dart';

enum AuthMethods {
  anonymous,
  magicLink,
  password,
  google,
  apple,
}

class AuthConfig {
  const AuthConfig({
    this.authMethods = const [
      AuthMethods.magicLink,
      AuthMethods.google,
      AuthMethods.apple,
    ],
    this.onGenerateProfilePicture,
    this.onGenerateProfileName,
    required this.profileLink,
    required this.signInLink,
  });

  final List<AuthMethods> authMethods;
  final String profileLink;
  final String signInLink;
  final Widget Function(BuildContext context)? onGenerateProfilePicture;
  final String Function(BuildContext context)? onGenerateProfileName;

  bool get anonymousEnabled => authMethods.contains(AuthMethods.anonymous);
  bool get passwordEnabled => authMethods.contains(AuthMethods.password);
  bool get magicLinkEnabled => authMethods.contains(AuthMethods.magicLink);
  bool get googleEnabled => authMethods.contains(AuthMethods.google);
  bool get appleEnabled => authMethods.contains(AuthMethods.apple);

  bool get isSignInEnabled =>
      anonymousEnabled || magicLinkEnabled || googleEnabled || appleEnabled;
}
