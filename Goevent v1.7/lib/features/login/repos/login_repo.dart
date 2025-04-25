import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/models/user_model.dart';

import '../data/data_sources/login_remote_datasource.dart';

class LoginRepo {
  final LoginRemoteDataSource _loginRemoteDataSource;

  LoginRepo({required LoginRemoteDataSource loginRemoteDataSource})
      : _loginRemoteDataSource = loginRemoteDataSource;

  Future<User> loginWithGoogle({
    required String email,
    required String name,
 
  }) async {
    log("LoginRepo: Attempting to login with Google - email: $email");
    try {
      final user = await _loginRemoteDataSource.loginWithGoogle(
        email: email,
        name: name,
      
      );
      log("LoginRepo: Google login successful for user: ${user}");
      return user;
    } catch (e) {
      log("LoginRepo: Error during Google login: $e");
      rethrow;
    }
  }

  Future<Response> loginWithEmail({required String email}) async {
    log("LoginRepo: Attempting to login with email: $email");
    try {
      final response =
          await _loginRemoteDataSource.loginWithEmail(email: email);
      log("LoginRepo: Email login step completed for: $email");
      return response;
    } catch (e) {
      log("LoginRepo: Error during email login: $e");
      rethrow;
    }
  }

  Future<User> verifyOTP({required String email, required String otp}) async {
    log("LoginRepo: Verifying OTP for email: $email");
    try {
      final user =
          await _loginRemoteDataSource.verifyOTP(email: email, otp: otp);
      log("LoginRepo: OTP verification successful for user: ${user.email}");
      return user;
    } catch (e) {
      log("LoginRepo: Error during OTP verification: $e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    log("LoginRepo: Signing out user");
    // We could add additional logout logic here if needed
  }
}

final loginRepoProvider = Provider<LoginRepo>((ref) {
  return LoginRepo(
      loginRemoteDataSource: ref.read(loginRemoteDataSourceProvider));
});
