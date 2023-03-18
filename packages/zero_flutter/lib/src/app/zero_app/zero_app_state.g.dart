// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zero_app_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$zeroLocalizationsHash() => r'887d3d101c9bd554191ae8ea5bc6e81148ab7607';

/// See also [zeroLocalizations].
@ProviderFor(zeroLocalizations)
final zeroLocalizationsProvider = AutoDisposeProvider<TranslationsEn>.internal(
  zeroLocalizations,
  name: r'zeroLocalizationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$zeroLocalizationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ZeroLocalizationsRef = AutoDisposeProviderRef<TranslationsEn>;
String _$readyHash() => r'9b0af80d2cbb5bbd56bfec27f8227ff8d24e12a9';

/// See also [ready].
@ProviderFor(ready)
final readyProvider = AutoDisposeProvider<bool>.internal(
  ready,
  name: r'readyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$readyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReadyRef = AutoDisposeProviderRef<bool>;
String _$currentLocaleHash() => r'1446635b706c1725bbee14bad5e05ca6202187fa';

/// See also [CurrentLocale].
@ProviderFor(CurrentLocale)
final currentLocaleProvider = NotifierProvider<CurrentLocale, Locale>.internal(
  CurrentLocale.new,
  name: r'currentLocaleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentLocaleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentLocale = Notifier<Locale>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
