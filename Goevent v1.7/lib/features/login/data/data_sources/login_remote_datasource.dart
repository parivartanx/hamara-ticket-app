
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/utils/dio_client.dart';

import '../../../../models/user_model.dart';
import '../../../../utils/endPoints.dart';
import 'local_datasource.dart';

class LoginRemoteDataSource {
   final DioClient _dioClient;

   LoginRemoteDataSource({required DioClient dioClient}) : _dioClient = dioClient;

   Future<User> loginWithGoogle({required String email, required String name}) async {
    final response = await _dioClient.post(url: EndPoints.loginWithGoogle,
     body: {"email": email, "name": name});
     final accessToken = response.data['data']['accessToken'];
     final refreshToken = response.data['data']['refreshToken'];
     log("accessToken: $accessToken");
     log("refreshToken: $refreshToken");
     final user = response.data['data']['user'];
     final userModel = User.fromJson(user); 
     
     LocalDataSource().saveAccessToken(accessToken);
     LocalDataSource().saveRefreshToken(refreshToken);
     LocalDataSource().saveUser(userModel);
     return userModel;
   }
   
   Future<Response> loginWithEmail({required String email }) async {
     final response =  await _dioClient.post(url: EndPoints.loginWithEmail, body:{"email": email} );
     return response;
   }

   Future<User> verifyOTP({required String email,required String otp}) async {
    final response = await _dioClient.post(url: EndPoints.verifyEmailOtp, 
    body: {"email": email, "otp": otp});
    log("response of verifyOTP in Remote: ${response.data}");
    final user = response.data['data']['user'];
    final userModel = User.fromJson(user);
    LocalDataSource().saveAccessToken(response.data['data']['accessToken']);
    LocalDataSource().saveRefreshToken(response.data['data']['refreshToken']);
    LocalDataSource().saveUser(userModel);
    return userModel;
   }
   
}

final loginRemoteDataSourceProvider = Provider<LoginRemoteDataSource>((ref) {
  return LoginRemoteDataSource(dioClient: ref.read(dioClientProvider));
});