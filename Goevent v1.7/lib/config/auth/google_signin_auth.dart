import 'dart:developer';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
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

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      // IMPORTANT: Only sign out if we're sure there's a signed in user
      // This was signing out users right after sign-in
      if (_auth.currentUser != null && await _googleSignIn.isSignedIn()) {
        // Sign out to ensure a fresh session
        await _auth.signOut();
        await _googleSignIn.signOut();
        log("Signed out existing user to start fresh");
      }
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        log("Google sign-in was canceled by the user");
        throw FirebaseException(
            plugin: "login-cancelled",
            message: "Login cancelled by User",
            code: "CANCELLED"
            ); // User canceled the sign-in
      }

      log("User signed in with Google: ${googleUser.email}");
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final idToken = googleAuth.idToken;
      log("idToken: $idToken");
      return googleUser;
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
