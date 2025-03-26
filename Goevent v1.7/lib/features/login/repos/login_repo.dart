import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamaraticket/models/user_model.dart';

import '../data/data_sources/login_remote_datasource.dart';

class LoginRepo {
  final LoginRemoteDataSource _loginRemoteDataSource;

  LoginRepo({required LoginRemoteDataSource loginRemoteDataSource}) : _loginRemoteDataSource = loginRemoteDataSource;
  
  Future<User> loginWithGoogle({required String email, required String name}) async {
    await _loginRemoteDataSource.loginWithGoogle(email: email, name: name);
    return User(email: email, name: name);
  } 

  Future<Response> loginWithEmail({ required String email}) async {
    final response =  await _loginRemoteDataSource.loginWithEmail(email: email);
    log("login with email ${email}");
    return response;
  }

  Future<User> verifyOTP({required String email, required String otp}) async{
    final response = await _loginRemoteDataSource.verifyOTP(email: email, otp: otp);
    log("verifyOTP in  login Repo ${response}");
     return response;
  }
  
  


  Future<void> signOut() async {

  }
} 

final loginRepoProvider = Provider<LoginRepo>((ref) {
  return LoginRepo(loginRemoteDataSource: ref.read(loginRemoteDataSourceProvider));
});
