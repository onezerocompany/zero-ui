import 'package:zero_flutter/zero_flutter.dart';

export 'style_config.dart';
export 'auth_config.dart';

class AppConfigData {
  AppConfigData(
    BuildContext context, {
    required this.name,
    this.style = const StyleConfig(),
    this.buttons = const [],
    this.searchProviders = const [],
    this.localizationsDelegates = const [],
    this.supportedLocales = const [
      Locale('en'),
    ],
    required this.router,
    required this.authConfig,
  });

  final AuthConfig authConfig;

  final String name;
  final Router router;
  final StyleConfig style;

  // Omni Search and buttons
  final List<OmniButtonData> buttons;
  final List<SearchProvider Function(BuildContext context)> searchProviders;
  bool Function() searchEnabled = () => false;

  // Localization
  final List<LocalizationsDelegate> localizationsDelegates;
  final Iterable<Locale> supportedLocales;
}
