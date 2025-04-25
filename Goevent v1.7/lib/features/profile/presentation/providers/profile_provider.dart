import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/shared_prefs_manager.dart';
import '../../../../models/user_model.dart';

final profileProvider = AsyncNotifierProvider.autoDispose<ProfileNotifier, User?>(ProfileNotifier.new);

class ProfileNotifier extends AutoDisposeAsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    // Ensure SharedPrefsManager is initialized
    await SharedPrefsManager.init();
    return SharedPrefsManager.getUser();
  }

  // Refresh the profile (e.g., after login/logout)
  Future<void> refreshProfile() async {
    state = const AsyncValue.loading();
    try {
      await SharedPrefsManager.init();
      final user = SharedPrefsManager.getUser();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Update the profile in shared prefs and state
  Future<void> updateProfile(User user) async {
    await SharedPrefsManager.setUser(user);
    state = AsyncValue.data(user);
  }

  // Clear the profile (e.g., on logout)
  Future<void> clearProfile() async {
    await SharedPrefsManager.clearAuthData();
    state = const AsyncValue.data(null);
  }
}
