// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adaptive_context.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$breakPointHash() => r'aaa680321f87a30b2696bd87982cd9e827839938';

/// See also [breakPoint].
@ProviderFor(breakPoint)
final breakPointProvider = Provider<BreakPoint>.internal(
  breakPoint,
  name: r'breakPointProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$breakPointHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BreakPointRef = ProviderRef<BreakPoint>;
String _$panelsHash() => r'92d2e9b1b8d07fed31ad71cf55326d4b2dfc035e';

/// See also [panels].
@ProviderFor(panels)
final panelsProvider = AutoDisposeProvider<int>.internal(
  panels,
  name: r'panelsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$panelsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PanelsRef = AutoDisposeProviderRef<int>;
String _$screenSizeHash() => r'3e19bcc18374d32b49fc40ed144a9099deb09635';

/// See also [ScreenSize].
@ProviderFor(ScreenSize)
final screenSizeProvider = NotifierProvider<ScreenSize, Size>.internal(
  ScreenSize.new,
  name: r'screenSizeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$screenSizeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ScreenSize = Notifier<Size>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
