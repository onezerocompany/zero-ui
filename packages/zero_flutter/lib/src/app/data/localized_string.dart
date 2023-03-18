import 'package:zero_flutter/zero_flutter.dart';

class LocalizedString {
  LocalizedString({
    Map<String, String>? translations,
  }) : translations = translations ?? {};

  Map<String, String> translations;

  String get(Locale locale) {
    return translations[locale.languageCode] ?? translations['en'] ?? "";
  }

  String set(Locale locale, String value) {
    return translations[locale.languageCode] = value;
  }

  toJson() {
    return translations.toString();
  }

  factory LocalizedString.fromJson(Map<String, dynamic> json) {
    return LocalizedString(
      translations: json.map((key, value) => MapEntry(key, value as String)),
    );
  }
}
