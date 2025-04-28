import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer';
import '../../../../utils/shared_prefs_manager.dart';
import '../../../../models/user_model.dart';

final profileProvider = AsyncNotifierProvider.autoDispose<ProfileNotifier, User?>(ProfileNotifier.new);

class ProfileNotifier extends AutoDisposeAsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    try {
      // Ensure SharedPrefsManager is initialized
      await SharedPrefsManager.init();
      final user = await SharedPrefsManager.getUser();
      log("ProfileProvider: Retrieved user from SharedPrefs: ${user?.name}");
      return user;
    } catch (e) {
      log("ProfileProvider: Error retrieving user: $e");
      return null;
    }
  }

  // Refresh the profile (e.g., after login/logout)
  Future<void> refreshProfile() async {
    state = const AsyncValue.loading();
    try {
      await SharedPrefsManager.init();
      final user = await SharedPrefsManager.getUser();
      log("ProfileProvider: Refreshed user from SharedPrefs: ${user?.name}");
      state = AsyncValue.data(user);
    } catch (e, st) {
      log("ProfileProvider: Error refreshing profile: $e");
      state = AsyncValue.error(e, st);
    }
  }

  // Update the profile in shared prefs and state
  Future<void> updateProfile(User user) async {
    try {
      final success = await SharedPrefsManager.setUser(user);
      if (success) {
        log("ProfileProvider: Successfully updated user in SharedPrefs: ${user.name}");
        state = AsyncValue.data(user);
      } else {
        log("ProfileProvider: Failed to update user in SharedPrefs");
        throw Exception("Failed to update user in SharedPreferences");
      }
    } catch (e, st) {
      log("ProfileProvider: Error updating profile: $e");
      state = AsyncValue.error(e, st);
    }
  }

  // Clear the profile (e.g., on logout)
  Future<void> clearProfile() async {
    try {
      final success = await SharedPrefsManager.clearAuthData();
      if (success) {
        log("ProfileProvider: Successfully cleared auth data");
        state = const AsyncValue.data(null);
      } else {
        log("ProfileProvider: Failed to clear auth data");
        throw Exception("Failed to clear auth data");
      }
    } catch (e, st) {
      log("ProfileProvider: Error clearing profile: $e");
      state = AsyncValue.error(e, st);
    }
  }
}
