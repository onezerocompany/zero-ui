import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<OAuthCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    throw PlatformException(
      code: 'ERROR_ABORTED_BY_USER',
      message: 'Sign in aborted by user',
    );
  }

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return credential;
}
