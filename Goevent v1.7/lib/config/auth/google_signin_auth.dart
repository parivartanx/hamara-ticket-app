import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
    serverClientId:
        '731582399542-c8ruqv5no25e4hevuojf7puns5sff3ar.apps.googleusercontent.com', // Add your web client ID here
  );

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      log("User signed in with Google: ${googleUser?.email}");
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final idToken = googleAuth.idToken;
      log("idToken: $idToken");
      return googleUser;
    } catch (error) {
      log("Error signing in with Google: $error");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    print("User signed out from Google.");
  }
}
