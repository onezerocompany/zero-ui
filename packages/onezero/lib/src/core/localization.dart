import 'package:flutter/widgets.dart';

/// A [Map] that associates a [Locale] with a [String].
typedef LocalizedStrings = Map<Locale, String>;

/// A class that represents localized content for a specific scope.
class LocalizedContent {
  const LocalizedContent({
    required this.scope,
    required this.strings,
  });

  /// The scope of the localized content.
  final String scope;

  /// A map that associates a key with a [LocalizedStrings] map.
  final Map<String, LocalizedStrings> strings;

  /// Returns the localized string for the given key.
  ///
  /// If the key is not found, it returns a string indicating that the key is missing.
  /// If the key is found but the localized string is not available for the current locale,
  /// it returns a string indicating that the localized string is missing for the current locale.
  String get(String key) {
    final value = strings[key];
    if (value == null) {
      return 'Missing: $scope($key)';
    }
    final locale = value.keys.first;
    return value[locale] ?? 'Missing: $scope($key) for $locale';
  }
}

/// A class that manages the localization of content for a specific scope.
class LocalizationRegistry {
  LocalizationRegistry({
    this.currentLocale = const Locale('en', 'US'),
    this.fallbackLocale = const Locale('en', 'US'),
  });

  /// The current locale used for localization.
  final Locale currentLocale;

  /// The fallback locale used for localization.
  final Locale fallbackLocale;

  /// A map that associates a scope with a [LocalizedContent] object.
  final Map<String, LocalizedContent> _localeStrings = {};

  /// Registers the localized content for a specific scope.
  void registerLocaleStrings(LocalizedContent localeStrings) {
    _localeStrings[localeStrings.scope] = localeStrings;
  }

  static LocalizationRegistry of(BuildContext context) {
    return LocalizationProvider.of(context);
  }

  /// Returns the localized string for the given scope and key.
  ///
  /// If the localized string is not available for the current locale, it falls back to the fallback locale.
  /// If the localized string is not found, it returns a string indicating that the key is missing.
  /// If the localized string is found but not available for the current locale, it returns a string indicating that the localized string is missing for the current locale.
  String getLocalizedString({
    required scope,
    required key,
    Locale? locale,
  }) {
    final l = locale ?? currentLocale;
    final localeStrings = _localeStrings[l.toString()] ??
        _localeStrings[fallbackLocale.toString()];
    if (localeStrings == null) {
      return 'Missing: $scope $key for $l';
    }
    final scopedLocaleStrings = _localeStrings.values
        .where((ls) =>
            ls.scope == scope &&
            ls.strings.keys.first.toString() == l.toString())
        .toList();
    if (scopedLocaleStrings.isEmpty) {
      return 'No locale strings found for $l and scope $scope';
    }
    return scopedLocaleStrings.first.get(key);
  }
}

class LocalizationProvider extends InheritedWidget {
  final LocalizationRegistry registry;

  const LocalizationProvider({
    Key? key,
    required this.registry,
    required Widget child,
  }) : super(key: key, child: child);

  static LocalizationRegistry of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<LocalizationProvider>();
    return provider!.registry;
  }

  @override
  bool updateShouldNotify(LocalizationProvider oldWidget) {
    return registry != oldWidget.registry;
  }
}
