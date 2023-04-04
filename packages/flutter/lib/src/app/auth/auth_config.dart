import 'package:zero_ui/zero_ui.dart';

part 'auth_config.g.dart';

enum AuthMethods {
  anonymous,
  magicLink,
  password,
  google,
  apple,
}

class AuthConfig {
  const AuthConfig({
    this.authMethods = const [],
    this.profileLink,
    this.signInLink,
    this.saveProfileDetails,
    this.sendMailVerification,
    this.sendMagicLink,
    this.sendPasswordReset,
  });

  final List<AuthMethods> authMethods;
  final String? profileLink;
  final String? signInLink;

  final Function(
    String uid,
    FormValues values,
  )? saveProfileDetails;
  final MailAction? sendMailVerification;
  final MailActionWithEmail? sendMagicLink;
  final MailActionWithEmail? sendPasswordReset;
}

@riverpod
AuthConfig authConfig(AuthConfigRef ref) {
  final config = ref.watch(appConfigProvider);
  return config.auth;
}

class EnabledAuthMethods {
  const EnabledAuthMethods({
    this.any = false,
    this.anonymous = false,
    this.magicLink = false,
    this.password = false,
    this.google = false,
    this.apple = false,
  });

  final bool any;
  final bool anonymous;
  final bool magicLink;
  final bool password;
  final bool google;
  final bool apple;
}

@riverpod
EnabledAuthMethods enabledAuthMethods(EnabledAuthMethodsRef ref) {
  final config = ref.watch(authConfigProvider);
  return EnabledAuthMethods(
    any: config.authMethods.isNotEmpty,
    anonymous: config.authMethods.contains(AuthMethods.anonymous),
    magicLink: config.authMethods.contains(AuthMethods.magicLink),
    password: config.authMethods.contains(AuthMethods.password),
    google: config.authMethods.contains(AuthMethods.google),
    apple: config.authMethods.contains(AuthMethods.apple),
  );
}
