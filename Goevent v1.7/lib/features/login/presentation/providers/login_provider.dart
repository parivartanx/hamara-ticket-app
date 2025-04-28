import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/features/profile/presentation/providers/profile_provider.dart';
import 'package:hamaraticket/models/user_model.dart';
import 'dart:developer';
import '../../repos/login_repo.dart';

class LoginProvider extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    return null;
  }

  Future<void> loginWithGoogle({
      required String email,
      required String name,
      }) async {
    try {
      state = const AsyncLoading();
      final user = await ref.read(loginRepoProvider).loginWithGoogle(
            email: email,
            name: name,
          );
          
      // Explicitly refresh the profile provider to ensure it loads the latest user data
      await ref.read(profileProvider.notifier).refreshProfile();
      
      // Get the refreshed user profile
      final userProfile = await ref.read(profileProvider.future);
      log("User Profile after refresh: $userProfile");
      
      state = AsyncData(user);
    } catch (e, st) {
      log("Error in loginWithGoogle: $e");
      state = AsyncError(e, st);
    }
  }
}

final loginProvider =
    AsyncNotifierProvider<LoginProvider, User?>(() => LoginProvider());
