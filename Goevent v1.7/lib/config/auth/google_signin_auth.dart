import 'dart:developer';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInAuth {
  late final GoogleSignIn _googleSignIn;
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  GoogleSignInAuth() {
    // Different configuration based on platform
    if (Platform.isAndroid) {
      _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
        // No need for serverClientId on Android - it's in google-services.json
      );
    } else if (Platform.isIOS) {
      _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
        clientId:
            '731582399542-emnu0k11vjd5hca925ebq8kravssslki.apps.googleusercontent.com', // iOS client ID
      );
    } else {
      // Web or other platforms
      _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
        serverClientId:
            '731582399542-c8ruqv5no25e4hevuojf7puns5sff3ar.apps.googleusercontent.com',
      );
    }

    log("Initialized GoogleSignIn for platform: ${Platform.operatingSystem}");
  }

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      // IMPORTANT: Only sign out if we're sure there's a signed in user
      // This was signing out users right after sign-in
      if (_auth.currentUser != null && await _googleSignIn.isSignedIn()) {
        // Sign out to ensure a fresh session
        await _auth.signOut();
        await _googleSignIn.signOut();
        log("Signed out existing user to start fresh");
      }

      log("Starting Google Sign-in flow on ${Platform.operatingSystem}...");

      // Handle silent sign-in first (might work if user previously signed in)
      GoogleSignInAccount? googleUser;

      try {
        googleUser = await _googleSignIn.signInSilently();
        if (googleUser != null) {
          log("Successfully signed in silently with Google");
        }
      } catch (e) {
        log("Silent sign-in failed, will try interactive: $e");
      }

      // If silent sign-in didn't work, try interactive
      if (googleUser == null) {
        // Trigger the Google Sign-in flow
        googleUser = await _googleSignIn.signIn();
      }

      if (googleUser == null) {
        log("User cancelled Google Sign-in");
        return null;
      }

      log("User signed in with Google: ${googleUser.email}");

      // Get the authentication details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.idToken == null) {
        log("Error: Google Auth idToken is null");
        throw Exception("Failed to get idToken from Google");
      }

      log("Obtained Google ID token, length: ${googleAuth.idToken!.length}");
      log("Obtained Google access token, length: ${googleAuth.accessToken?.length ?? 'null'}");

      // Create a new credential for Firebase
      final firebase_auth.AuthCredential credential =
          firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      log("Created Firebase credential, attempting to sign in...");

      // Sign in to Firebase with the Google credential
      final firebase_auth.UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final firebase_auth.User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        log("Error: Firebase user is null after sign in");
        throw Exception("Failed to sign in with Firebase");
      }

      log("Successfully signed in with Firebase: ${firebaseUser.uid}");

      // Get the token for backend verification
      final String? idToken = await firebaseUser.getIdToken(true);

      if (idToken == null || idToken.isEmpty) {
        log("Error: Firebase token is null or empty");
        throw Exception("Failed to get Firebase token");
      }

      final String firebaseToken = idToken;

      log("Got Firebase token for backend verification, length: ${firebaseToken.length}");

      // Return user data and token for backend
      return {
        'email': firebaseUser.email ?? googleUser.email,
        'name': firebaseUser.displayName ?? googleUser.displayName ?? 'Unknown',
        'firebaseToken': firebaseToken,
        'userId': firebaseUser.uid,
        'photoUrl': firebaseUser.photoURL ?? googleUser.photoUrl,
      };
    } catch (error) {
      log("Error signing in with Google: $error");
      // Print detailed stack trace for debugging
      if (error is Exception) {
        log("Exception details: ${error.toString()}",
            stackTrace: StackTrace.current);
      }

      // DO NOT sign out on error - this was causing the immediate sign-out
      // We'll let the caller handle errors instead

      // Return a more specific error message based on the error
      if (error.toString().contains("network_error")) {
        throw Exception("Network error: Please check your internet connection");
      } else if (error.toString().contains("sign_in_failed") ||
          error.toString().contains("sign_in_canceled")) {
        throw Exception("Sign-in was canceled or failed");
      } else if (error.toString().contains("PlatformException")) {
        // This gives the specific platform error
        throw Exception("Platform configuration error: ${error.toString()}");
      } else {
        throw Exception("Google Sign-in failed: ${error.toString()}");
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      log("User signed out from Google and Firebase.");
    } catch (e) {
      log("Error signing out: $e");
      throw Exception("Sign out failed: $e");
    }
  }
}
