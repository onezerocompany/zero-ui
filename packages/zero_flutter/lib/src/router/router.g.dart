// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerHash() => r'97bd01812f02ab62e8698f0b1fd83ce253bab1ec';

/// See also [router].
@ProviderFor(router)
final routerProvider = AutoDisposeProvider<Router>.internal(
  router,
  name: r'routerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RouterRef = AutoDisposeProviderRef<Router>;
String _$currentRouterLevelHash() =>
    r'7e661fe32fe3f38fdea521f9eb8b260aa8fe0ff0';

/// See also [currentRouterLevel].
@ProviderFor(currentRouterLevel)
final currentRouterLevelProvider = AutoDisposeProvider<int>.internal(
  currentRouterLevel,
  name: r'currentRouterLevelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentRouterLevelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentRouterLevelRef = AutoDisposeProviderRef<int>;
String _$currentRouterEntryHash() =>
    r'ad1de384cf8a6f67d783de8e4e2bf6f9958e2728';

/// See also [CurrentRouterEntry].
@ProviderFor(CurrentRouterEntry)
final currentRouterEntryProvider =
    AutoDisposeNotifierProvider<CurrentRouterEntry, RouterEntry?>.internal(
  CurrentRouterEntry.new,
  name: r'currentRouterEntryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentRouterEntryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentRouterEntry = AutoDisposeNotifier<RouterEntry?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
