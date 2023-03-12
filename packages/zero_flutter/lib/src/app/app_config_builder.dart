import 'package:zero_flutter/zero_flutter.dart';

export 'style_config.dart';

part 'app_config_builder.g.dart';

class AppConfigBuilder {
  const AppConfigBuilder({
    required this.appName,
    required this.locales,
    required this.style,
    required this.auth,
    required this.router,
    required this.omni,
  });

  final Localized<String> appName;
  final List<Locale> locales;
  final StyleConfig style;
  final Localized<AuthConfig> auth;
  final Localized<OmniConfig> omni;
  final Localized<Router> router;
}

@Riverpod(keepAlive: true)
class CurrentAppConfigBuilder extends _$CurrentAppConfigBuilder {
  @override
  AppConfigBuilder build() {
    return AppConfigBuilder(
      appName: (locale) => "Zero Flutter",
      locales: const [Locale("en")],
      style: const StyleConfig(),
      auth: (locale) => const AuthConfig(),
      omni: (locale) => const OmniConfig(),
      router: (locale) => Router(locale),
    );
  }

  void set(AppConfigBuilder builder) {
    state = builder;
  }
}
