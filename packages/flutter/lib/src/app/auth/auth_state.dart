import 'package:firebase_auth/firebase_auth.dart';
import 'package:zero_ui/zero_ui.dart';

part 'auth_state.g.dart';

/// Streaming provider that emits the current user's ID.
/// It's attached to FirebaseAuth and will emit a new value whenever the user
/// signs in or out. It will also emit a new value when the user's ID changes.
@riverpod
Stream<String?> userId(UserIdRef ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user?.uid);
}
