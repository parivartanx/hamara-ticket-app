import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/utils/dio_client.dart';

import '../../../../models/user_model.dart';
import '../../../../utils/endPoints.dart';
import 'local_datasource.dart';

class LoginRemoteDataSource {
  final DioClient _dioClient;
  final LocalDataSource _localDataSource = LocalDataSource();

  LoginRemoteDataSource({required DioClient dioClient})
      : _dioClient = dioClient;

  Future<User> loginWithGoogle({
    required String email,
    required String name,
 
  }) async {
    try {
      // log("RemoteDataSource: Sending Google sign-in request to backend");
      // log("RemoteDataSource: Using URL: ${EndPoints.baseUrl}${EndPoints.loginWithGoogle}");

      final response =
          await _dioClient.post(url: EndPoints.loginWithGoogle, body: {
        "email": email,
        "name": name,
      
      });

      // log("RemoteDataSource: Google sign-in response status: ${response.statusCode}");

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Backend returned error code: ${response.statusCode}");
      }

      if (!response.data.containsKey('data')) {
        log("RemoteDataSource: Invalid response format - no data field: ${response.data}");
        throw Exception("Invalid response format from server");
      }

      final responseData = response.data['data'];

      if (!responseData.containsKey('accessToken') ||
          !responseData.containsKey('refreshToken') ||
          !responseData.containsKey('user')) {
        log("RemoteDataSource: Missing required fields in response: ${response.data}");
        throw Exception("Invalid response format: missing required fields");
      }

      final accessToken = responseData['accessToken'];
      final refreshToken = responseData['refreshToken'];


      final userData = responseData['user'];
      final userModel = User.fromJson(userData);

      // Save authentication data
      await _localDataSource.saveAccessToken(accessToken);
      await _localDataSource.saveRefreshToken(refreshToken);
      await _localDataSource.saveUser(userModel);

      return userModel;
    } catch (e) {
      log("RemoteDataSource: Error during Google sign-in request: $e");
      rethrow;
    }
  }

  Future<Response> loginWithEmail({required String email}) async {
    try {
      log("RemoteDataSource: Sending email login request for: $email");
      final response = await _dioClient
          .post(url: EndPoints.loginWithEmail, body: {"email": email});
      log("RemoteDataSource: Email login request successful, status: ${response.statusCode}");
      return response;
    } catch (e) {
      log("RemoteDataSource: Error during email login request: $e");
      rethrow;
    }
  }

  Future<User> verifyOTP({required String email, required String otp}) async {
    try {
      log("RemoteDataSource: Verifying OTP for email: $email");
      final response = await _dioClient.post(
          url: EndPoints.verifyEmailOtp, body: {"email": email, "otp": otp});

      log("RemoteDataSource: OTP verification response status: ${response.statusCode}");

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Backend returned error code: ${response.statusCode}");
      }

      if (!response.data.containsKey('data')) {
        log("RemoteDataSource: Invalid response format - no data field: ${response.data}");
        throw Exception("Invalid response format from server");
      }

      final responseData = response.data['data'];

      if (!responseData.containsKey('user') ||
          !responseData.containsKey('accessToken') ||
          !responseData.containsKey('refreshToken')) {
        log("RemoteDataSource: Missing required fields in response: ${response.data}");
        throw Exception("Invalid response format: missing required fields");
      }

      final user = responseData['user'];
      final userModel = User.fromJson(user);

      // Save authentication data
      await _localDataSource.saveAccessToken(responseData['accessToken']);
      await _localDataSource.saveRefreshToken(responseData['refreshToken']);
      await _localDataSource.saveUser(userModel);

      log("RemoteDataSource: Successfully saved user data after OTP verification");

      return userModel;
    } catch (e) {
      log("RemoteDataSource: Error during OTP verification: $e");
      rethrow;
    }
  }
}

final loginRemoteDataSourceProvider = Provider<LoginRemoteDataSource>((ref) {
  return LoginRemoteDataSource(dioClient: ref.read(dioClientProvider));
});
