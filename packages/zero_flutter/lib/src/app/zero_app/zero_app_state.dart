import 'package:zero_flutter/zero_flutter.dart';
import '../../../i18n/translations.dart';

part 'zero_app_state.g.dart';

final globalContainer = ProviderContainer();

@Riverpod(keepAlive: true)
class CurrentLocale extends _$CurrentLocale {
  @override
  Locale build() {
    return WidgetsBinding.instance.window.locale;
  }

  void setLocale(Locale locale) {
    state = locale;
  }
}

// Locale locale(LocaleRef ref) {
//   return const Locale("en");
// }

@riverpod
TranslationsEn zeroLocalizations(ZeroLocalizationsRef ref) {
  final locale = ref.watch(currentLocaleProvider);
  final appLocale = AppLocale.values.firstWhereOrNull(
    (appLocale) => appLocale.languageCode == locale.languageCode,
  );
  return appLocale == null ? AppLocale.en.build() : appLocale.build();
}

@riverpod
bool ready(ReadyRef ref) {
  return false;
}
