import 'package:zero_flutter/zero_flutter.dart';

export 'app_config_builder.dart';

part 'app_config.g.dart';

typedef Localized<T> = T Function(Locale locale);

class AppConfig {
  const AppConfig({
    required this.appName,
    required this.locales,
    required this.style,
    required this.auth,
    required this.router,
    required this.omni,
  });

  final String appName;
  final List<Locale> locales;

  final StyleConfig style;
  final AuthConfig auth;
  final Router router;
  final OmniConfig omni;
}

@Riverpod(keepAlive: true)
AppConfig appConfig(AppConfigRef ref) {
  final builder = ref.watch(currentAppConfigBuilderProvider);
  final locale = ref.read(currentLocaleProvider);
  return AppConfig(
    appName: builder.appName(locale),
    locales: builder.locales,
    style: builder.style,
    auth: builder.auth(locale),
    router: builder.router(locale),
    omni: builder.omni(locale),
  );
}
