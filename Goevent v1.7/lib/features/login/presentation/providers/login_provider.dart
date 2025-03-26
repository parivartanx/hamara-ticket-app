import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/models/user_model.dart';
import 'dart:developer';
import '../../repos/login_repo.dart';

class LoginProvider extends AsyncNotifier<User?>{
  @override
  Future<User?> build() async {
    return null;
  }

  Future<void> loginWithGoogle({required String email, required String name}) async {
    try {
    
      log("Login with google email: $email, name: $name");
      state = const AsyncLoading();
      final user  = await ref.read(loginRepoProvider).loginWithGoogle(email: email, name: name);
      state = AsyncData(user);
       // Update this when you have user data
    } catch (e, st) {
      log("Error in loginWithGoogle: $e");
      state = AsyncError(e, st);
    }
  }

  
}

final loginProvider = AsyncNotifierProvider<LoginProvider, User?>(() => LoginProvider());
