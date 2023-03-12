// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userIdHash() => r'ab0bdf918aa7f9f4cc3ffbc986497c080c01d160';

/// Streaming provider that emits the current user's ID.
/// It's attached to FirebaseAuth and will emit a new value whenever the user
/// signs in or out. It will also emit a new value when the user's ID changes.
///
/// Copied from [userId].
@ProviderFor(userId)
final userIdProvider = AutoDisposeStreamProvider<String?>.internal(
  userId,
  name: r'userIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserIdRef = AutoDisposeStreamProviderRef<String?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
