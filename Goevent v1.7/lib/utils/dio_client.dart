import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/login/data/data_sources/local_datasource.dart';
import 'endPoints.dart';

class DioClient {
    final Dio _dio = Dio();
    final _localDataSource = LocalDataSource();

    DioClient(){
      _dio.options = BaseOptions(
        baseUrl: EndPoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      );
      
      // Add interceptor to dynamically add auth token to every request
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // Get fresh token for every request
            final accessToken = await _localDataSource.getAccessToken();
            final user = await _localDataSource.getUser();
            
            if (accessToken != null) {
              options.headers["Authorization"] = "Bearer $accessToken";
              // log("Adding auth token to request: Bearer $accessToken");
            }
            
            if (user != null) {
              options.headers["userId"] = user.id;
            }
            
            options.headers["Content-Type"] = "application/json";
            return handler.next(options);
          },
        ),
      );
    }

    Future<Response> post({required String url, required Map<String,dynamic> body})async{
      try{
        final response = await _dio.post(url,
        data: body
        );
        return response;
      }
      on DioException catch(e){
        throw handleDioError(e);
      }
      catch(e){
        rethrow;
      }
    }

    Future<Response> put({required String url,required Map<String,dynamic> body})async{
      try{
        final response = await _dio.put(url,data:body);
        return response;
      }
      on DioException catch(e){
        throw handleDioError(e);
      }
      catch(e){
        rethrow;
      }
    }

    Future<Response> get({required String url})async{
      try{
        log("Making GET request to: $url");
        final response = await _dio.get(url);
        return response;
      }
      on DioException catch(e){
        log("DioException in GET request: ${e.message}");
        throw handleDioError(e);
      }
      catch(e){
        log("Unexpected error in GET request: $e");
        rethrow;
      }
    }

    Future<Response> getWithParams({required String url,Map<String,dynamic>? params})async{
      try{
        log("URL: $url");
        log("Params: $params");
        final response = await _dio.get(url,queryParameters: params);
        return response;
      }
      on DioException catch(e){
        throw handleDioError(e);
      }
      catch(e){
        rethrow;
      }
    }

    Future<Response> patch({required String url,Map<String,dynamic>? body})async{
      try{
        final response = await _dio.patch(url,data: body);
        return response;
      }
      on DioException catch(e){
        throw handleDioError(e);
      }
      catch(e){
        rethrow;
      }
    }

     dynamic handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please try again.";
      case DioExceptionType.sendTimeout:
        return "Send request timed out.";
      case DioExceptionType.receiveTimeout:
        return "Receive request timed out.";
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
        return "No internet connection.";
      default:
        return "Unexpected error occurred.";
    }
  }

   String _handleBadResponse(Response? response) {
    if (response == null) return "Unknown server error.";
    final responseData = response.data;
    if (responseData is Map<String, dynamic> && responseData.containsKey("message")) {
      return responseData["message"];
    }
    switch (response.statusCode) {
      case 400:
        return response.statusMessage != null ? response.data! : "Bad request. Please check your input.";
      case 401:
        return "Unauthorized access. Please log in again.";
      case 403:
        return "Access denied.";
      case 404:
        return "Resource not found.";
      case 500:
        return "Internal server error.";
      default:
        return "Error: ${response.statusCode}";
    }
  }
}

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});