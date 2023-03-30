import 'package:flutter/foundation.dart';
import 'package:zero_flutter/zero_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'localized_string.g.dart';

@firestoreSerializable
class LocalizedString {
  LocalizedString({
    Map<String, String>? translations,
  }) : translations = translations ?? {};

  Map<String, String> translations;

  String get(Locale locale, {bool fallback = true}) {
    return translations[locale.languageCode] ??
        (fallback ? translations['en'] ?? "" : "");
  }

  String set(Locale locale, String value) {
    return translations[locale.languageCode] = value;
  }

  toJson() => translations;
  factory LocalizedString.fromJson(Map<String, dynamic> json) =>
      _$LocalizedStringFromJson({'translations': json});

  @override
  operator ==(other) {
    if (other is! LocalizedString) {
      return false;
    }
    return mapEquals(translations, other.translations);
  }

  @override
  int get hashCode => translations.hashCode;

  @override
  toString() {
    String result = "";
    translations.forEach((key, value) {
      result += "$key: $value, ";
    });
    return result;
  }

  static LocalizedString fromMap(Map<String, String> map) {
    return LocalizedString(translations: Map<String, String>.from(map));
  }

  toMap() => translations;
}
